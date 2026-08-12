import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/Top100/TopsWidgets.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';
import 'package:spotify/Services/data_service.dart';

class TopsMusicView extends StatefulWidget {
  const TopsMusicView({super.key});

  @override
  State<TopsMusicView> createState() => _TopsMusicViewState();
}

class _TopsMusicViewState extends State<TopsMusicView> {
  List<Map<String, dynamic>> _songs = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // ✅ استخدام الأغاني الأكثر استماعاً عبر التاريخ (cachedTopSongs)
    if (DataService.cachedTopSongs != null &&
        DataService.cachedTopSongs!.isNotEmpty) {
      debugPrint('✅ Using All-Time Top Songs from DataService');
      final tracks = DataService.cachedTopSongs!;
      final songs = tracks.asMap().entries.map((entry) {
        final index = entry.key;
        final track = entry.value;

        return {
          'rank': '${index + 1}',
          'image': track['image'] ?? '',
          'title': track['title'] ?? '',
          'subtitle': track['subtitle'] ?? '',
          'duration': track['Time'] ?? '0:00',
          'preview': track['preview'] ?? '',
        };
      }).toList();

      setState(() {
        _songs = songs;
        _isLoading = false;
      });
      return;
    }

    // ✅ إذا لم تكن البيانات مخزنة، نجلبها من الـ API
    await _fetchTopSongs();
  }

  Future<void> _fetchTopSongs() async {
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

        if (tracks.isEmpty) {
          setState(() {
            _errorMessage = 'لا توجد أغاني حالياً';
            _isLoading = false;
          });
          return;
        }

        final songs = tracks.asMap().entries.map((entry) {
          final index = entry.key;
          final track = entry.value;

          final durationRaw = track['duration'] ?? 0;
          final duration = durationRaw is int ? durationRaw : 0;
          final minutes = duration ~/ 60;
          final seconds = duration % 60;

          return {
            'rank': '${index + 1}',
            'image': track['album']?['cover_medium']?.toString() ?? '',
            'title': track['title']?.toString() ?? '',
            'subtitle': track['artist']?['name']?.toString() ?? '',
            'duration': '$minutes:${seconds.toString().padLeft(2, '0')}',
            'preview': track['preview']?.toString() ?? '',
          };
        }).toList();

        // ✅ تخزين البيانات في DataService
        DataService.cachedTopSongs = tracks.map<Map<String, String>>((track) {
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
          };
        }).toList();

        setState(() {
          _songs = songs;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'خطأ في تحميل البيانات';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل الاتصال بالإنترنت';
        _isLoading = false;
      });
      debugPrint('❌ Error fetching top songs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (_errorMessage != null) {
      return SizedBox(
        height: 400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _loadData,
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

    if (_songs.isEmpty) {
      return const SizedBox(
        height: 400,
        child: Center(
          child: Text('لا توجد أغاني', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ✅ عنوان "All-Time Greatest Hits"
        ..._songs.map((song) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Nowplayingpage(
                    title: song['title'].toString(),
                    artist: song['subtitle'].toString(),
                    imageUrl: song['image'].toString(),
                    previewUrl: song['preview'].toString(),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Topswidgets(
                rank: song['rank'].toString(),
                imageUrl: song['image'].toString(),
                title: song['title'].toString(),
                subtitle: song['subtitle'].toString(),
                duration: song['duration'].toString(),
              ),
            ),
          );
        }).toList(),

        const SizedBox(height: 16),
      ],
    );
  }
}
