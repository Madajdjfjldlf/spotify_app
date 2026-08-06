// lib/Common/Services/data_service.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  // ✅ البيانات المخزنة
  static List<Map<String, String>>? cachedAlbums;
  static List<Map<String, String>>? cachedSongs;

  // ✅ جلب جميع البيانات (يُستدعى من Splash)
  static Future<void> loadAllData() async {
    try {
      // جلب الأغاني الشعبية
      final songsResponse = await http
          .get(Uri.parse('https://api.deezer.com/chart/0/tracks?limit=40'))
          .timeout(const Duration(seconds: 8));

      if (songsResponse.statusCode == 200) {
        final songsData = json.decode(songsResponse.body);
        final List tracks =
            songsData['data'] ?? songsData['tracks']?['data'] ?? [];

        // استخراج الألبومات الفريدة من الأغاني
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
        cachedAlbums = albumMap.values.toList();

        // تخزين الأغاني للـ CdMusicView
        cachedSongs = tracks.map<Map<String, String>>((track) {
          return {
            'image': track['album']?['cover_medium'] ?? '',
            'title': track['title'] ?? '',
            'artist': track['artist']?['name'] ?? '',
          };
        }).toList();
      }
    } catch (e) {
      print('❌ Error loading data: $e');
    }
  }
}
