import 'dart:async';
import 'package:flutter/material.dart';

import 'package:spotify/Pages/AppPages/Search/deezer_models.dart';
import 'package:spotify/Pages/AppPages/Search/deezer_service.dart';

import 'package:spotify/ThemApp.dart/App_Color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  List<DeezerTrack> _tracks = [];
  List<DeezerArtist> _artists = [];
  List<DeezerAlbum> _albums = [];
  bool _isLoading = false;
  bool _hasSearched = false;
  String? _error;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (_controller.text.isNotEmpty) {
        _performSearch(_controller.text);
      }
    });
  }

  void _onChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.trim().length >= 2) {
        _performSearch(value);
      } else if (value.isEmpty) {
        setState(() {
          _hasSearched = false;
          _tracks = [];
          _artists = [];
          _albums = [];
        });
      }
    });
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _isLoading = true;
      _hasSearched = true;
      _error = null;
    });

    try {
      final filterIndex = _tabController.index;
      final results = await DeezerService.searchAll(query);

      setState(() {
        if (filterIndex == 0) {
          _tracks = results['tracks'] ?? [];
          _artists = results['artists'] ?? [];
          _albums = results['albums'] ?? [];
        } else if (filterIndex == 1) {
          _tracks = results['tracks'] ?? [];
          _artists = [];
          _albums = [];
        } else if (filterIndex == 2) {
          _tracks = [];
          _artists = results['artists'] ?? [];
          _albums = [];
        } else {
          _tracks = [];
          _artists = [];
          _albums = results['albums'] ?? [];
        }
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    _focusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Appcolor.DarkBg : Appcolor.LightBg;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black45;
    final searchBg = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF0F0F0);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: searchBg,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: textColor,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        color: searchBg,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        autofocus: true,
                        onChanged: _onChanged,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Search songs, artists, albums...',
                          hintStyle: TextStyle(
                            color: subTextColor,
                            fontSize: 15,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: subTextColor,
                          ),
                          suffixIcon: _controller.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _controller.clear();
                                    _onChanged('');
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: subTextColor,
                                    size: 20,
                                  ),
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter Tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: searchBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Appcolor.Primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: subTextColor,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  padding: const EdgeInsets.all(4),
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                  tabs: const [
                    Tab(text: 'All'),
                    Tab(text: 'Songs'),
                    Tab(text: 'Artists'),
                    Tab(text: 'Albums'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Results
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Appcolor.Primary),
                    )
                  : _error != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_off_rounded,
                            size: 56,
                            color: subTextColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Connection error',
                            style: TextStyle(color: textColor, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => _performSearch(_controller.text),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    )
                  : !_hasSearched
                  ? _buildRecentSearches(textColor, subTextColor, searchBg)
                  : _buildResults(textColor, subTextColor, isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(
    Color textColor,
    Color subTextColor,
    Color searchBg,
  ) {
    final recent = [
      'Adele',
      'Billie Eilish',
      'The Weeknd',
      'Drake',
      'Taylor Swift',
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        Text(
          'Recent Searches',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: recent.map((item) {
            return GestureDetector(
              onTap: () {
                _controller.text = item;
                _onChanged(item);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: searchBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.history_rounded, size: 16, color: subTextColor),
                    const SizedBox(width: 6),
                    Text(
                      item,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildResults(Color textColor, Color subTextColor, bool isDark) {
    if (_tracks.isEmpty && _artists.isEmpty && _albums.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_off_rounded, size: 56, color: subTextColor),
            const SizedBox(height: 12),
            Text(
              'No results found',
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: [
        // Songs
        if (_tracks.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Songs',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_tracks.length} found',
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._tracks.map(
            (track) => _SongResultTile(
              track: track,
              textColor: textColor,
              subTextColor: subTextColor,
              isDark: isDark,
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Artists
        if (_artists.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Artists',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_artists.length} found',
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _artists.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) => _ArtistResultCard(
                artist: _artists[index],
                textColor: textColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],

        // Albums
        if (_albums.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Albums',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_albums.length} found',
                style: TextStyle(color: subTextColor, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _albums.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (_, index) => _AlbumResultCard(
                album: _albums[index],
                textColor: textColor,
                subTextColor: subTextColor,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

// ───────────────────────────────────────────
// SEARCH RESULT WIDGETS
// ───────────────────────────────────────────

class _SongResultTile extends StatelessWidget {
  final DeezerTrack track;
  final Color textColor;
  final Color subTextColor;
  final bool isDark;

  const _SongResultTile({
    required this.track,
    required this.textColor,
    required this.subTextColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              track.albumCover ?? '',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 56,
                height: 56,
                color: Colors.grey.shade800,
                child: const Icon(Icons.music_note, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.titleShort,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${track.artistName} • ${track.albumTitle ?? 'Single'}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: subTextColor, fontSize: 13),
                ),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Appcolor.Primary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Appcolor.Primary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArtistResultCard extends StatelessWidget {
  final DeezerArtist artist;
  final Color textColor;

  const _ArtistResultCard({required this.artist, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Appcolor.Primary.withOpacity(0.3),
              width: 2,
            ),
            image: artist.picture != null
                ? DecorationImage(
                    image: NetworkImage(artist.picture!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: artist.picture == null
              ? const Icon(Icons.person, color: Colors.white38, size: 40)
              : null,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 120,
          child: Text(
            artist.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _AlbumResultCard extends StatelessWidget {
  final DeezerAlbum album;
  final Color textColor;
  final Color subTextColor;

  const _AlbumResultCard({
    required this.album,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              album.coverBig ?? album.cover ?? '',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 150,
                height: 150,
                color: Colors.grey.shade800,
                child: const Icon(Icons.album, color: Colors.white24),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            album.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            album.artistName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: subTextColor, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
