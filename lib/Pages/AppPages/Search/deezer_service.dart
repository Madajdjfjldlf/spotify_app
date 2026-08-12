import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Pages/AppPages/Search/deezer_models.dart';

class DeezerService {
  static const String _baseUrl = 'https://api.deezer.com';

  // Chart Tracks (Trending)
  static Future<List<DeezerTrack>> getChartTracks({int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/chart/0/tracks?limit=$limit'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((e) => DeezerTrack.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load chart');
  }

  // New Releases
  static Future<List<DeezerAlbum>> getNewReleases({int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/chart/0/albums?limit=$limit'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((e) => DeezerAlbum.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load new releases');
  }

  // Popular Artists
  static Future<List<DeezerArtist>> getPopularArtists({int limit = 10}) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/chart/0/artists?limit=$limit'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] as List)
          .map((e) => DeezerArtist.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load artists');
  }

  // Search All
  static Future<Map<String, dynamic>> searchAll(
    String query, {
    int limit = 15,
  }) async {
    if (query.trim().isEmpty) return {};

    final results = await Future.wait([
      http.get(
        Uri.parse(
          '$_baseUrl/search/track?q=${Uri.encodeComponent(query)}&limit=$limit',
        ),
      ),
      http.get(
        Uri.parse(
          '$_baseUrl/search/artist?q=${Uri.encodeComponent(query)}&limit=10',
        ),
      ),
      http.get(
        Uri.parse(
          '$_baseUrl/search/album?q=${Uri.encodeComponent(query)}&limit=10',
        ),
      ),
    ]);

    final tracks = results[0].statusCode == 200
        ? (jsonDecode(results[0].body)['data'] as List)
              .map((e) => DeezerTrack.fromJson(e))
              .toList()
        : <DeezerTrack>[];

    final artists = results[1].statusCode == 200
        ? (jsonDecode(results[1].body)['data'] as List)
              .map((e) => DeezerArtist.fromJson(e))
              .toList()
        : <DeezerArtist>[];

    final albums = results[2].statusCode == 200
        ? (jsonDecode(results[2].body)['data'] as List)
              .map((e) => DeezerAlbum.fromJson(e))
              .toList()
        : <DeezerAlbum>[];

    return {'tracks': tracks, 'artists': artists, 'albums': albums};
  }
}
