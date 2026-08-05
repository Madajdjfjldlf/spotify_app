import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<Map<String, String>> items = [];
  bool isLoading = true;
  String? errorMessage;

  Future<void> fetchLatestSongs() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    const String playlistId = '3155776842';
    const String url = 'https://api.deezer.com/playlist/$playlistId/tracks';

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List tracks = data['data'] ?? [];

        if (tracks.isEmpty) {
          errorMessage = 'لا توجد أغاني حالياً';
        } else {
          items = tracks.map<Map<String, String>>((track) {
            final title = (track['title'] ?? '').toString();
            final artist = (track['artist']?['name'] ?? '').toString();
            final imageUrl = track['album']?['cover_medium'] ?? '';
            final preview = track['preview'] ?? ''; // ✅ إضافة preview
            return {
              'title': title,
              'subtitle': artist,
              'image': imageUrl,
              'preview': preview, // ✅
            };
          }).toList();

          items.shuffle();
        }
      } else {
        errorMessage = 'خطأ في الخادم (${response.statusCode})';
      }
    } catch (e) {
      debugPrint('Error fetching songs: $e');
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
    fetchLatestSongs();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: CircularProgressIndicator(color: Color(0xFF1DB954)),
        ),
      );
    }

    if (errorMessage != null) {
      return SizedBox(
        height: 240,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.white54, size: 40),
              const SizedBox(height: 8),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.white54),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: fetchLatestSongs,
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

    if (items.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Text(
            'لا توجد أغاني لعرضها',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return SizedBox(
      height: 240,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 24),
        itemBuilder: (context, index) {
          final song = items[index];
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
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
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: NetworkImage(song['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 5,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'Assest/Vectors/Play.svg',
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  song['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  song['subtitle']!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
