import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spotify/Pages/AppPages/Search/jamendo_models.dart';

class JamendoService {
  static const String _clientId = '56e6b845'; // استخدم Client ID الخاص بك
  static const String _baseUrl = 'https://api.jamendo.com/v3.0';

  // ───── الأغاني الشائعة ─────
  static Future<List<JamendoTrack>> getPopularTracks({int limit = 8}) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/tracks/?client_id=$_clientId&format=json&order=popularity_total&limit=$limit&include=stats',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      return results.map((e) => JamendoTrack.fromJson(e)).toList();
    }
    throw Exception('Failed to load popular tracks');
  }

  // ───── الفنانين المشهورين ─────
  static Future<List<JamendoArtist>> getPopularArtists({int limit = 8}) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/artists/?client_id=$_clientId&format=json&order=popularity_total&limit=$limit',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      return results.map((e) => JamendoArtist.fromJson(e)).toList();
    }
    throw Exception('Failed to load popular artists');
  }

  // ───── الإصدارات الجديدة ─────
  static Future<List<JamendoAlbum>> getNewReleases({int limit = 10}) async {
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/albums/?client_id=$_clientId&format=json&order=releasedate&limit=$limit',
      ),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'] ?? [];
      return results.map((e) => JamendoAlbum.fromJson(e)).toList();
    }
    throw Exception('Failed to load new releases');
  }

  // ───── البحث الشامل ─────
  static Future<Map<String, dynamic>> searchAll(
    String query, {
    int limit = 15,
  }) async {
    if (query.trim().isEmpty) return {};

    final results = await Future.wait([
      http.get(
        Uri.parse(
          '$_baseUrl/tracks/?client_id=$_clientId&format=json&search=$query&limit=$limit',
        ),
      ),
      http.get(
        Uri.parse(
          '$_baseUrl/artists/?client_id=$_clientId&format=json&search=$query&limit=10',
        ),
      ),
      http.get(
        Uri.parse(
          '$_baseUrl/albums/?client_id=$_clientId&format=json&search=$query&limit=10',
        ),
      ),
    ]);

    final tracks = results[0].statusCode == 200
        ? (jsonDecode(results[0].body)['results'] as List)
              .map((e) => JamendoTrack.fromJson(e))
              .toList()
        : <JamendoTrack>[];

    final artists = results[1].statusCode == 200
        ? (jsonDecode(results[1].body)['results'] as List)
              .map((e) => JamendoArtist.fromJson(e))
              .toList()
        : <JamendoArtist>[];

    final albums = results[2].statusCode == 200
        ? (jsonDecode(results[2].body)['results'] as List)
              .map((e) => JamendoAlbum.fromJson(e))
              .toList()
        : <JamendoAlbum>[];

    return {'tracks': tracks, 'artists': artists, 'albums': albums};
  }
}
