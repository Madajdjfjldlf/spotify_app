import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AlbumPage.dart/AlbumWidgetView.dart';

import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class Albumpage extends StatefulWidget {
  final String title;
  final String albumId;

  const Albumpage({super.key, required this.title, required this.albumId});

  @override
  State<Albumpage> createState() => _AlbumpageState();
}

class _AlbumpageState extends State<Albumpage> {
  Map<String, dynamic>? _albumDetails;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAlbumDetails();
  }

  // ───── جلب تفاصيل الألبوم ─────
  Future<void> _fetchAlbumDetails() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final url = 'https://api.deezer.com/album/${widget.albumId}';
    debugPrint('📡 Fetching album details: $url');

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _albumDetails = data;
          _isLoading = false;
        });
      } else if (response.statusCode == 404) {
        setState(() {
          _errorMessage = '⚠️ الألبوم غير موجود (404)';
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'خطأ في الخادم (${response.statusCode})';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل الاتصال بالإنترنت';
        _isLoading = false;
      });
      debugPrint('❌ Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5);
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: BasicAppBar(
        Title: Text(
          widget.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF1DB954)),
            )
          : _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.orange,
                      size: 60,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _errorMessage!,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: _fetchAlbumDetails,
                      icon: const Icon(Icons.refresh),
                      label: const Text('إعادة المحاولة'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1DB954),
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : _albumDetails == null
          ? const Center(
              child: Text(
                'لا توجد بيانات',
                style: TextStyle(color: Colors.white54),
              ),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // ─── صورة الألبوم (SliverAppBar) ───
                SliverAppBar(
                  expandedHeight: 320,
                  pinned: true,
                  stretch: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [StretchMode.zoomBackground],
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        // صورة الألبوم
                        Image.network(
                          _albumDetails!['cover_big'] ??
                              _albumDetails!['cover_medium'] ??
                              '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            color: Colors.grey.shade800,
                            child: const Icon(
                              Icons.album,
                              color: Colors.white24,
                              size: 80,
                            ),
                          ),
                        ),
                        // تدرج من الأسفل
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  bgColor.withOpacity(0.9),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // معلومات الألبوم في الأسفل
                        Positioned(
                          bottom: 16,
                          left: 20,
                          right: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _albumDetails!['title'] ?? widget.title,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _albumDetails!['artist']?['name'] ?? '',
                                style: TextStyle(
                                  color: subTextColor,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    '${_albumDetails!['nb_tracks'] ?? 0} songs',
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _albumDetails!['release_date']?.substring(
                                          0,
                                          4,
                                        ) ??
                                        '',
                                    style: TextStyle(
                                      color: subTextColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ─── زر تشغيل الكل ───
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // ✅ فتح Nowplayingpage مع أول أغنية إذا كانت موجودة
                              // أو فتح صفحة الألبوم نفسها مع قائمة التشغيل
                              // نمرر بيانات الألبوم فقط، وسيتم تحميل الأغاني في Nowplayingpage
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Nowplayingpage(
                                    title:
                                        _albumDetails!['title'] ?? widget.title,
                                    artist:
                                        _albumDetails!['artist']?['name'] ?? '',
                                    imageUrl: _albumDetails!['cover_big'] ?? '',
                                    previewUrl:
                                        '', // سيتم تحميل الأغاني من الـ albumId
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 28,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'Play All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1DB954),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: isDark
                                ? const Color(0xFF2A2A2A)
                                : const Color(0xFFF0F0F0),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite_border_rounded,
                              color: subTextColor,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ─── قائمة الأغاني باستخدام Albumwidgetview ───
                SliverToBoxAdapter(
                  child: Catogriesalbumview(
                    albumId: widget.albumId,
                    albumsList: [],
                  ),
                ),

                // مسافة سفلية
                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
    );
  }
}
