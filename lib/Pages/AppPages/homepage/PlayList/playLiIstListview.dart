import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/homepage/PlayList/PlayListwidget.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({super.key});

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  List<Map<String, String>> songs = [];
  bool isLoading = true;
  String? errorMessage;

  String formatDuration(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> fetchDeezerSongs() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    const String url = 'https://api.deezer.com/chart/0/tracks?limit=50';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? data['tracks']?['data'] ?? [];

        if (tracks.isEmpty) {
          errorMessage = 'لا توجد أغاني متاحة حالياً';
        } else {
          songs = tracks.map<Map<String, String>>((track) {
            final title = (track['title'] ?? '').toString();
            final artist = (track['artist']?['name'] ?? '').toString();
            final durationRaw = track['duration'];
            final duration = durationRaw is int ? durationRaw : 0;
            final timestr = formatDuration(duration);
            final image = track['album']?['cover_medium'] ?? '';
            final preview = track['preview'] ?? ''; // ✅ إضافة preview
            final albumTitle = (track['album']?['title'] ?? '').toString(); // ✅
            final albumImage = track['album']?['cover_medium'] ?? ''; // ✅
            return {
              'title': title,
              'subtitle': artist,
              'Time': timestr,
              'image': image,
              'preview': preview, // ✅
              'albumTitle': albumTitle, // ✅
              'albumImage': albumImage, // ✅
            };
          }).toList();

          songs.shuffle();
        }
      } else {
        errorMessage = 'خطأ في الخادم (${response.statusCode})';
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      errorMessage = 'فشل الاتصال بالإنترنت أو الخادم';
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
    fetchDeezerSongs();
  }

  void _navigateToNowPlaying(BuildContext context, Map<String, String> song) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: song['title'],
          artist: song['subtitle'],
          imageUrl: song['image'],
          previewUrl: song['preview'], // ✅ تمرير preview
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, color: Colors.white54, size: 50),
            const SizedBox(height: 10),
            Text(
              errorMessage!,
              style: const TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton.icon(
              onPressed: fetchDeezerSongs,
              icon: const Icon(Icons.refresh),
              label: const Text('حاول مجدداً'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1DB954),
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    if (songs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'لا توجد أغاني لعرضها',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Playlistwidget(
            title: song['title']!,
            subTitle: song['subtitle']!,
            Time: song['Time']!,
            onTap: () => _navigateToNowPlaying(context, song),
            onPlayTap: () => _navigateToNowPlaying(context, song),
          ),
        );
      },
    );
  }
}
