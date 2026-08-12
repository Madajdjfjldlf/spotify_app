import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/homepage/PlayList/PlayListwidget.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class ArtistSongsList extends StatefulWidget {
  final String artistName;
  final Function(List<Map<String, String>> songs)? onSongsLoaded;

  const ArtistSongsList({
    super.key,
    required this.artistName,
    this.onSongsLoaded,
  });

  @override
  State<ArtistSongsList> createState() => _ArtistSongsListState();
}

class _ArtistSongsListState extends State<ArtistSongsList> {
  List<Map<String, String>> songs = [];
  bool isLoading = true;
  String? errorMessage;

  String formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> fetchArtistSongs() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final String query = Uri.encodeComponent(widget.artistName);
    final String url = 'https://api.deezer.com/search?q=$query&limit=15';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? [];

        if (tracks.isEmpty) {
          errorMessage = 'لا توجد أغاني لهذا الفنان';
        } else {
          songs = tracks.map<Map<String, String>>((track) {
            final title = (track['title'] ?? '').toString();
            final artist = (track['artist']?['name'] ?? '').toString();
            final durationRaw = track['duration'];
            final duration = durationRaw is int ? durationRaw : 0;
            final timestr = formatDuration(duration);
            final image = track['album']?['cover_medium'] ?? '';
            final preview = track['preview'] ?? '';
            final albumTitle = (track['album']?['title'] ?? '').toString();
            final albumImage = track['album']?['cover_medium'] ?? '';
            final songId = (track['id']?.toString() ?? '0');
            return {
              'title': title,
              'subtitle': artist,
              'Time': timestr,
              'image': image,
              'preview': preview,
              'albumTitle': albumTitle,
              'albumImage': albumImage,
              'songId': songId,
            };
          }).toList();

          if (widget.onSongsLoaded != null) {
            widget.onSongsLoaded!(songs);
          }
        }
      } else {
        errorMessage = 'خطأ في الخادم (${response.statusCode})';
      }
    } catch (e) {
      debugPrint('Error fetching artist songs: $e');
      errorMessage = 'فشل الاتصال بالإنترنت';
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArtistSongs();
  }

  void _navigateToNowPlaying(BuildContext context, Map<String, String> song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: song['title'],
          artist: song['subtitle'],
          imageUrl: song['image'],
          previewUrl: song['preview'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (errorMessage != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: fetchArtistSongs,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1DB954),
                  foregroundColor: Colors.black,
                ),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (songs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text('لا توجد أغاني', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Playlistwidget(
            title: song['title']!,
            subTitle: song['subtitle']!,
            Time: song['Time']!,
            songId: int.tryParse(song['songId'] ?? '0') ?? 0,
            onTap: () => _navigateToNowPlaying(context, song),
            onPlayTap: () => _navigateToNowPlaying(context, song),
          ),
        );
      },
    );
  }
}
