import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/Library/CdMusic/Cdmusic.dart';

class Cdmusicview extends StatefulWidget {
  const Cdmusicview({super.key});

  @override
  State<Cdmusicview> createState() => _CdmusicviewState();
}

class _CdmusicviewState extends State<Cdmusicview> {
  List<Map<String, String>> songs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPopularSongs();
  }

  Future<void> fetchPopularSongs() async {
    const String url = 'https://api.deezer.com/chart/0/tracks?limit=10';
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? data['tracks']?['data'] ?? [];
        if (tracks.isNotEmpty) {
          setState(() {
            songs = tracks.map<Map<String, String>>((track) {
              return {
                'image': track['album']?['cover_medium'] ?? '',
                'title': track['title'] ?? '',
                'artist': track['artist']?['name'] ?? '',
                'preview': track['preview'] ?? '', // ✅ جلب preview
              };
            }).toList();
          });
        }
      }
    } catch (e) {
      debugPrint('Error fetching songs: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (songs.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(
          child: Text('لا توجد أغاني', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CdWidget(
              imageUrl: song['image']!,
              title: song['title']!,
              artist: song['artist']!,
              size: 140,
              previewUrl: song['preview'] ?? '', // ✅ تمرير preview
            ),
          );
        },
      ),
    );
  }
}
