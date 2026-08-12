import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataService {
  static List<Map<String, String>>? cachedTracks;
  static List<Map<String, String>>? cachedAlbums;
  static List<Map<String, String>>? cachedArtists;
  static List<Map<String, String>>? cachedTopSongs;
  static bool isLoading = false;
  static String? errorMessage;

  // ───── بيانات احتياطية ─────
  static final List<Map<String, String>> _strongFallback = [
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Utopia',
      'Subtitle': 'Travis Scott',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/644133989f1391ee8a7e8f84c6572e3a/500x500-000000-80-0-0.jpg',
      'Title': 'Guts',
      'Subtitle': 'Olivia Rodrigo',
      'id': '1234567890',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'After Hours',
      'Subtitle': 'The Weeknd',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'SOS',
      'Subtitle': 'SZA',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Midnights',
      'Subtitle': 'Taylor Swift',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': "Harry's House",
      'Subtitle': 'Harry Styles',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Good Kid, M.A.A.D City',
      'Subtitle': 'Kendrick Lamar',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Blonde',
      'Subtitle': 'Frank Ocean',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'Currents',
      'Subtitle': 'Tame Impala',
      'id': '3155776842',
    },
    {
      'photo':
          'https://e-cdns-images.dzcdn.net/images/cover/95e82716ba7c4875ed66a5688cf5fa1e/500x500-000000-80-0-0.jpg',
      'Title': 'AM',
      'Subtitle': 'Arctic Monkeys',
      'id': '3155776842',
    },
  ];

  // ───── تحميل جميع البيانات ─────
  static Future<bool> loadAllData([BuildContext? context]) async {
    isLoading = true;
    errorMessage = null;

    try {
      debugPrint('🔄 Loading data from Deezer API...');

      final results = await Future.wait([
        _fetchChartTracks(),
        _fetchMultipleAlbums(),
        _fetchChartArtists(),
        _fetchTopSongs(),
      ]);

      cachedTracks = results[0];
      cachedAlbums = results[1];
      cachedArtists = results[2];
      cachedTopSongs = results[3];

      if (cachedAlbums == null || cachedAlbums!.isEmpty) {
        debugPrint('⚠️ No albums from API, using STRONG FALLBACK');
        cachedAlbums = List.from(_strongFallback);
      } else {
        cachedAlbums!.shuffle();
      }

      debugPrint('✅ Data loaded:');
      debugPrint('   Tracks: ${cachedTracks?.length ?? 0}');
      debugPrint('   Albums: ${cachedAlbums?.length ?? 0}');
      debugPrint('   Artists: ${cachedArtists?.length ?? 0}');
      debugPrint('   Top Songs: ${cachedTopSongs?.length ?? 0}');

      if (context != null) {
        await _precacheImages(context);
      }

      isLoading = false;
      return true;
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      debugPrint('❌ Error loading data: $e');
      cachedAlbums = List.from(_strongFallback);
      return false;
    }
  }

  // ───── تحميل الصور مسبقاً ─────
  static Future<void> _precacheImages(BuildContext context) async {
    final List<String> imageUrls = [];

    if (cachedTracks != null) {
      for (var track in cachedTracks!) {
        final image = track['image'] ?? '';
        if (image.isNotEmpty && image.startsWith('http')) {
          imageUrls.add(image);
        }
      }
    }

    if (cachedTopSongs != null) {
      for (var track in cachedTopSongs!) {
        final image = track['image'] ?? '';
        if (image.isNotEmpty && image.startsWith('http')) {
          imageUrls.add(image);
        }
      }
    }

    if (cachedAlbums != null) {
      for (var album in cachedAlbums!) {
        final image = album['photo'] ?? '';
        if (image.isNotEmpty && image.startsWith('http')) {
          imageUrls.add(image);
        }
      }
    }

    if (cachedArtists != null) {
      for (var artist in cachedArtists!) {
        final image = artist['picture'] ?? '';
        if (image.isNotEmpty && image.startsWith('http')) {
          imageUrls.add(image);
        }
      }
    }

    debugPrint('🖼️ Pre-caching ${imageUrls.length} images...');

    final List<Future> futures = [];
    for (var url in imageUrls) {
      futures.add(
        precacheImage(
          NetworkImage(url),
          context,
          onError: (_, __) => debugPrint('⚠️ Failed to pre-cache: $url'),
        ),
      );
    }

    await Future.wait(futures);
    debugPrint('✅ Image pre-caching completed!');
  }

  // ───── جلب الأغاني الشائعة ─────
  static Future<List<Map<String, String>>> _fetchChartTracks() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.deezer.com/chart/0/tracks?limit=50'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? data['tracks']?['data'] ?? [];

        return tracks.map<Map<String, String>>((track) {
          final durationRaw = track['duration'] ?? 0;
          final duration = durationRaw is int ? durationRaw : 0;
          final minutes = duration ~/ 60;
          final seconds = duration % 60;

          return {
            'title': (track['title'] ?? '').toString(),
            'subtitle': (track['artist']?['name'] ?? '').toString(),
            'Time': '$minutes:${seconds.toString().padLeft(2, '0')}',
            'image': (track['album']?['cover_medium'] ?? '').toString(),
            'preview': (track['preview'] ?? '').toString(),
            'albumTitle': (track['album']?['title'] ?? '').toString(),
            'albumImage': (track['album']?['cover_medium'] ?? '').toString(),
            'albumId': (track['album']?['id']?.toString() ?? '').toString(),
            'songId': (track['id']?.toString() ?? '0'),
          };
        }).toList();
      }
      return [];
    } catch (e) {
      debugPrint('❌ Error fetching tracks: $e');
      return [];
    }
  }

  // ───── جلب الأغاني الأكثر استماعاً (Top 50 Global) ─────
  static Future<List<Map<String, String>>> _fetchTopSongs() async {
    const String playlistId = '3155776842';
    const String url =
        'https://api.deezer.com/playlist/$playlistId/tracks?limit=50';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? [];

        return tracks.map<Map<String, String>>((track) {
          final durationRaw = track['duration'] ?? 0;
          final duration = durationRaw is int ? durationRaw : 0;
          final minutes = duration ~/ 60;
          final seconds = duration % 60;

          return {
            'image': track['album']?['cover_medium']?.toString() ?? '',
            'title': track['title']?.toString() ?? '',
            'subtitle': track['artist']?['name']?.toString() ?? '',
            'Time': '$minutes:${seconds.toString().padLeft(2, '0')}',
            'preview': track['preview']?.toString() ?? '',
            'songId': (track['id']?.toString() ?? '0'),
          };
        }).toList();
      }
      return [];
    } catch (e) {
      debugPrint('❌ Error fetching top songs: $e');
      return [];
    }
  }

  // ───── جلب الألبومات من مصادر متعددة ─────
  static Future<List<Map<String, String>>> _fetchMultipleAlbums() async {
    final List<Map<String, String>> allAlbums = [];

    final chartAlbums = await _fetchChartAlbums();
    allAlbums.addAll(chartAlbums);

    final playlistAlbums = await _fetchPlaylistAlbums();
    allAlbums.addAll(playlistAlbums);

    final searchQueries = ['pop', 'rock', 'hiphop', 'love', 'summer'];
    for (var query in searchQueries) {
      final searchAlbums = await _fetchSearchAlbums(query);
      allAlbums.addAll(searchAlbums);
    }

    final Map<String, Map<String, String>> uniqueAlbums = {};
    for (var album in allAlbums) {
      final id = album['id'] ?? '';
      if (id.isNotEmpty && !uniqueAlbums.containsKey(id)) {
        uniqueAlbums[id] = album;
      }
    }

    final result = uniqueAlbums.values.toList();
    debugPrint('📡 Total unique albums fetched: ${result.length}');
    return result;
  }

  // ───── جلب الألبومات من Chart ─────
  static Future<List<Map<String, String>>> _fetchChartAlbums() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.deezer.com/chart/0/albums?limit=10'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List albums = data['data'] ?? [];
        return _parseAlbums(albums);
      }
      return [];
    } catch (e) {
      debugPrint('❌ Chart albums error: $e');
      return [];
    }
  }

  // ───── جلب ألبومات من قوائم التشغيل ─────
  static Future<List<Map<String, String>>> _fetchPlaylistAlbums() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.deezer.com/chart/0/playlists?limit=10'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List playlists = data['data'] ?? [];
        final List<Map<String, String>> albums = [];

        for (var playlist in playlists) {
          final playlistId = playlist['id'];
          if (playlistId != null) {
            final detailResponse = await http
                .get(
                  Uri.parse(
                    'https://api.deezer.com/playlist/$playlistId/tracks?limit=5',
                  ),
                )
                .timeout(const Duration(seconds: 5));

            if (detailResponse.statusCode == 200) {
              final detailData = json.decode(detailResponse.body);
              final List tracks = detailData['data'] ?? [];
              for (var track in tracks) {
                final album = track['album'];
                if (album != null) {
                  albums.add({
                    'photo': (album['cover_medium'] ?? '').toString(),
                    'Title': (album['title'] ?? '').toString(),
                    'Subtitle': (track['artist']?['name'] ?? '').toString(),
                    'id': (album['id']?.toString() ?? '').toString(),
                  });
                }
              }
            }
          }
        }
        return albums;
      }
      return [];
    } catch (e) {
      debugPrint('❌ Playlist albums error: $e');
      return [];
    }
  }

  // ───── جلب ألبومات من البحث ─────
  static Future<List<Map<String, String>>> _fetchSearchAlbums(
    String query,
  ) async {
    try {
      final response = await http
          .get(
            Uri.parse('https://api.deezer.com/search/album?q=$query&limit=5'),
          )
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List albums = data['data'] ?? [];
        return _parseAlbums(albums);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // ───── دالة مساعدة لتحويل بيانات الألبوم ─────
  static List<Map<String, String>> _parseAlbums(List albums) {
    return albums.map<Map<String, String>>((album) {
      return {
        'photo': (album['cover_medium'] ?? '').toString(),
        'Title': (album['title'] ?? '').toString(),
        'Subtitle': (album['artist']?['name'] ?? '').toString(),
        'id': (album['id']?.toString() ?? '').toString(),
      };
    }).toList();
  }

  // ───── جلب الفنانين المشهورين ─────
  static Future<List<Map<String, String>>> _fetchChartArtists() async {
    try {
      final response = await http
          .get(Uri.parse('https://api.deezer.com/chart/0/artists?limit=10'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List artists = data['data'] ?? [];

        return artists.map<Map<String, String>>((artist) {
          return {
            'name': (artist['name'] ?? '').toString(),
            'picture': (artist['picture_medium'] ?? '').toString(),
            'id': (artist['id']?.toString() ?? '').toString(),
          };
        }).toList();
      }
      return [];
    } catch (e) {
      debugPrint('❌ Error fetching artists: $e');
      return [];
    }
  }

  // ───── التحقق من وجود بيانات ─────
  static bool hasData() {
    return cachedAlbums != null && cachedAlbums!.isNotEmpty;
  }

  // ───── إعادة تحميل البيانات ─────
  static Future<bool> refreshData([BuildContext? context]) async {
    cachedTracks = null;
    cachedAlbums = null;
    cachedArtists = null;
    cachedTopSongs = null;
    return await loadAllData(context);
  }
}
