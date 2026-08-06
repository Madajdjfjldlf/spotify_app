import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/CdMusicView.dart';

class Librarypage extends StatefulWidget {
  const Librarypage({super.key});

  @override
  State<Librarypage> createState() => _LibrarypageState();
}

class _LibrarypageState extends State<Librarypage> {
  List<Map<String, String>> newAlbums = [];
  List<Map<String, String>> popularAlbums = [];
  List<Map<String, String>> editorPicks = [];
  List<Map<String, String>> moreAlbums = [];

  bool isLoading = true;
  String? errorMessage;

  static const List<Map<String, String>> _fallbackAlbums = [
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Utopia',
      'Subtitle': 'Travis Scott',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/644133989f1391ee8a7e8f84c6572e3a/500x500-000000-80-0-0.jpg',
      'Title': 'Guts',
      'Subtitle': 'Olivia Rodrigo',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'For All The Dogs',
      'Subtitle': 'Drake',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Lover',
      'Subtitle': 'Taylor Swift',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'After Hours',
      'Subtitle': 'The Weeknd',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'SOS',
      'Subtitle': 'SZA',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Midnights',
      'Subtitle': 'Taylor Swift',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': "Harry's House",
      'Subtitle': 'Harry Styles',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFallbackData();
    fetchAlbumsFromTracks();
  }

  void _loadFallbackData() {
    newAlbums = List.from(_fallbackAlbums);
    popularAlbums = List.from(_fallbackAlbums);
    editorPicks = List.from(_fallbackAlbums);
    moreAlbums = List.from(_fallbackAlbums);
  }

  Future<void> fetchAlbumsFromTracks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    const String url = 'https://api.deezer.com/chart/0/tracks?limit=40';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? data['tracks']?['data'] ?? [];

        if (tracks.isNotEmpty) {
          final Map<String, Map<String, String>> albumMap = {};
          for (var track in tracks) {
            final album = track['album'];
            if (album != null) {
              final title = album['title'] ?? '';
              final cover = album['cover_medium'] ?? '';
              final artist = track['artist']?['name'] ?? '';
              if (title.isNotEmpty && cover.isNotEmpty) {
                albumMap.putIfAbsent(
                  title,
                  () => {'photo': cover, 'Title': title, 'Subtitle': artist},
                );
              }
            }
          }

          final List<Map<String, String>> uniqueAlbums = albumMap.values
              .toList();
          if (uniqueAlbums.isNotEmpty) {
            final int total = uniqueAlbums.length;
            final int chunkSize = (total / 4).ceil();
            setState(() {
              newAlbums = uniqueAlbums.take(chunkSize).toList();
              popularAlbums = uniqueAlbums
                  .skip(chunkSize)
                  .take(chunkSize)
                  .toList();
              editorPicks = uniqueAlbums
                  .skip(chunkSize * 2)
                  .take(chunkSize)
                  .toList();
              moreAlbums = uniqueAlbums.skip(chunkSize * 3).toList();
              errorMessage = null;
            });
          }
        }
      }
    } catch (e) {
      setState(() => errorMessage = 'فشل التحديث');
      debugPrint('❌ Update error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSection(
              title: 'New Albums',
              albums: newAlbums,
              isLoading: isLoading,
              error: errorMessage,
              onRetry: fetchAlbumsFromTracks,
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Popular Albums',
              albums: popularAlbums,
              isLoading: isLoading,
              error: errorMessage,
              onRetry: fetchAlbumsFromTracks,
            ),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Editor\'s Picks',
              albums: editorPicks,
              isLoading: isLoading,
              error: errorMessage,
              onRetry: fetchAlbumsFromTracks,
            ),
            const SizedBox(height: 20),
            _buildSection(title: 'Music For You', child: const Cdmusicview()),
            const SizedBox(height: 30),
            _buildSection(
              title: 'More Albums',
              albums: moreAlbums,
              isLoading: isLoading,
              error: errorMessage,
              onRetry: fetchAlbumsFromTracks,
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    List<Map<String, String>>? albums,
    bool isLoading = false,
    String? error,
    VoidCallback? onRetry,
    Widget? child,
  }) {
    if (child != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(title, isLoading: false, error: null),
          const SizedBox(height: 8),
          child,
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(title, isLoading: isLoading, error: error),
        const SizedBox(height: 8),
        if (albums != null && albums.isNotEmpty)
          Catogriesalbumview(albumsList: albums)
        else
          const SizedBox(
            height: 150,
            child: Center(
              child: Text(
                'لا توجد ألبومات',
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader(
    String title, {
    bool isLoading = false,
    String? error,
    VoidCallback? onRetry,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          if (isLoading)
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF1DB954),
              ),
            ),
          if (error != null && error.isNotEmpty)
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 18,
            ),
          const Spacer(),
          TextButton(
            onPressed: isLoading ? null : onRetry,
            child: Text(
              isLoading ? 'جاري...' : 'See All',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isLoading
                    ? Colors.grey
                    : (error != null ? Colors.orange : const Color(0xFF1DB954)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
