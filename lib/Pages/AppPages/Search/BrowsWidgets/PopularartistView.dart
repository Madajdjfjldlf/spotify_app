import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/PopularArtistWidget.dart';
import 'package:spotify/Services/data_service.dart'; // ✅ استيراد DataService
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart'; // للتنقل (اختياري)

class Popularartistview extends StatefulWidget {
  const Popularartistview({super.key});

  @override
  State<Popularartistview> createState() => _PopularartistviewState();
}

class _PopularartistviewState extends State<Popularartistview> {
  List<Map<String, String>> popularArtists = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadArtists();
  }

  // ✅ تحميل الفنانين من التخزين المؤقت أو من الـ API
  Future<void> _loadArtists() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    // ✅ 1. التحقق من وجود بيانات مخزنة
    if (DataService.cachedArtists != null &&
        DataService.cachedArtists!.isNotEmpty) {
      debugPrint('✅ Using cached artists from DataService');
      setState(() {
        popularArtists = DataService.cachedArtists!.map((artist) {
          return {
            'image': artist['picture'] ?? '',
            'ArtistName': artist['name'] ?? '',
          };
        }).toList();
        isLoading = false;
      });
      return;
    }

    // ✅ 2. إذا لم تكن هناك بيانات مخزنة، نجلبها من الـ API
    await _fetchArtistsFromApi();
  }

  // ───── جلب الفنانين من الـ API وتخزينها ─────
  Future<void> _fetchArtistsFromApi() async {
    const String url = 'https://api.deezer.com/chart/0/artists?limit=10';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List artists = data['data'] ?? [];

        if (artists.isEmpty) {
          setState(() {
            errorMessage = 'لا يوجد فنانين حالياً';
            isLoading = false;
          });
          return;
        }

        // ✅ تحويل البيانات وتخزينها في DataService
        final List<Map<String, String>> artistList = artists
            .map<Map<String, String>>((artist) {
              return {
                'image': artist['picture_medium'] ?? '',
                'ArtistName': artist['name'] ?? '',
              };
            })
            .toList();

        // ✅ تخزين في DataService بالشكل المتوقع (name, picture)
        DataService.cachedArtists = artists.map<Map<String, String>>((artist) {
          return {
            'name': artist['name'] ?? '',
            'picture': artist['picture_medium'] ?? '',
          };
        }).toList();

        setState(() {
          popularArtists = artistList;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'خطأ في الخادم (${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'فشل الاتصال بالإنترنت';
        isLoading = false;
      });
      debugPrint('❌ Error fetching artists: $e');
    }
  }

  // ✅ دالة التنقل إلى صفحة الفنان (اختياري)
  void _navigateToArtist(
    BuildContext context,
    String artistName,
    String imageUrl,
  ) {
    // يمكنك هنا جلب أغاني الفنان أو الانتقال إلى صفحة الفنان
    // حالياً سنفتح Nowplayingpage مع اسم الفنان
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: 'أغاني $artistName',
          artist: artistName,
          imageUrl: imageUrl,
          previewUrl: '',
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
                onPressed: _loadArtists,
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

    if (popularArtists.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'لا توجد فنانين',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularArtists.length,
        padding: const EdgeInsets.only(left: 16),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final info = popularArtists[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Popularartistwidget(
              image: info['image']!,
              ArtistName: info['ArtistName']!,
            ),
          );
        },
      ),
    );
  }
}
