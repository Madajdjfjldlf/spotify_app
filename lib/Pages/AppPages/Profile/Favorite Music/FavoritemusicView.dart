import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/MusicPage/NowplayingPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:spotify/Pages/AppPages/Profile/Favorite Music/FavoriteMusicWidget.dart';

class FavoritemusicView extends StatefulWidget {
  const FavoritemusicView({super.key});

  @override
  State<FavoritemusicView> createState() => _FavoritemusicViewState();
}

class _FavoritemusicViewState extends State<FavoritemusicView> {
  List<Map<String, dynamic>> _favoriteSongs = [];

  bool _isLoading = true;
  String? _errorMessage;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _loadFavoriteSongs();
  }

  Future<void> _loadFavoriteSongs() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final user = supabase.auth.currentUser;

    if (user == null) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
        _errorMessage = 'يرجى تسجيل الدخول لعرض المفضلة';
      });

      return;
    }

    try {
      final favoritesResult = await supabase
          .from('favorites')
          .select('song_id')
          .eq('user_id', user.id);

      if (favoritesResult.isEmpty) {
        if (!mounted) return;

        setState(() {
          _favoriteSongs = [];
          _isLoading = false;
        });

        return;
      }

      final List<int> songIds = favoritesResult
          .map<int>((item) => item['song_id'] as int)
          .toList();

      final List<Map<String, dynamic>> songs = [];

      for (final id in songIds) {
        try {
          final response = await http
              .get(Uri.parse('https://api.deezer.com/track/$id'))
              .timeout(const Duration(seconds: 5));

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);

            songs.add({
              'id': data['id'],
              'title': data['title'] ?? '',
              'artist': data['artist']?['name'] ?? '',
              'image': data['album']?['cover_medium'] ?? '',
              'preview': data['preview'] ?? '',
            });
          }
        } catch (e) {
          debugPrint('Error fetching track $id: $e');
        }
      }

      if (!mounted) return;

      setState(() {
        _favoriteSongs = songs;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading favorites: $e');

      if (!mounted) return;

      setState(() {
        _errorMessage = 'فشل تحميل المفضلة';
        _isLoading = false;
      });
    }
  }

  void refreshFavorites() {
    _loadFavoriteSongs();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox(
        height: 190,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 190,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage!, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _loadFavoriteSongs,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (_favoriteSongs.isEmpty) {
      return const SizedBox(height: 190, child: Center(child: Text('nothigs')));
    }

    return SizedBox(
      height: 190,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _favoriteSongs.length,
        itemBuilder: (context, index) {
          final song = _favoriteSongs[index];

          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Favoritemusicwidget(
              title: song['title'] ?? '',
              subtite: song['artist'] ?? '',
              photo: song['image'] ?? '',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Nowplayingpage(
                      title: song['title'] ?? '',
                      artist: song['artist'] ?? '',
                      imageUrl: song['image'] ?? '',
                      previewUrl: song['preview'] ?? '',
                    ),
                  ),
                ).then((_) {
                  refreshFavorites();
                });
              },
            ),
          );
        },
      ),
    );
  }
}
