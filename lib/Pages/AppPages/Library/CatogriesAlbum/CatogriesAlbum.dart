import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class Catogriesalbum extends StatefulWidget {
  const Catogriesalbum({
    super.key,
    required this.Photo,
    required this.Title,
    required this.Subtitle,
    this.previewUrl,
    this.songTitle,
    this.artistName,
  });

  final String Photo;
  final String Title;
  final String Subtitle;
  final String? previewUrl;
  final String? songTitle;
  final String? artistName;

  @override
  State<Catogriesalbum> createState() => _CatogriesalbumState();
}

class _CatogriesalbumState extends State<Catogriesalbum>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  ImageProvider _getImageProvider() {
    final String path = widget.Photo;
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }

  Future<void> _onTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() => _isPressed = false);
    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: widget.songTitle ?? widget.Title,
          artist: widget.artistName ?? widget.Subtitle,
          imageUrl: widget.Photo,
          previewUrl: widget.previewUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 180,
              width: 240,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // 🎧 القرص
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 85),
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Positioned(left: value, top: 15, child: child!);
                    },
                    child: RotationTransition(
                      turns: _spinController,
                      child: SizedBox(
                        height: 150,
                        width: 150,
                        child: CustomPaint(
                          painter: _VinylPainter(),
                          child: Center(
                            child: Container(
                              width: 55,
                              height: 55,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: _getImageProvider(),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.black87,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // 🎵 الغلاف
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: _getImageProvider(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            // ✅ تم تغليف النص بـ SizedBox لتحديد العرض وجعل العنوان ينزل لسطر جديد بأسلوب متناسق
            SizedBox(
              width:
                  160, // تحديد العرض بنفس عرض الغلاف لتقسيم الكلمات بشكل مريح
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Title: سطرين مقسمين بوضوح
                    Text(
                      widget.Title,
                      style: const TextStyle(
                        fontSize: 15, // حجم يناسب 3-4 كلمات في السطر
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2, // يسمح بسطرين فقط
                      softWrap: true, // يلتف للسطر الثاني
                      overflow:
                          TextOverflow.ellipsis, // يضيف (...) إذا زاد عن سطرين
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.Subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎼 رسم القرص
class _VinylPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final basePaint = Paint()
      ..color = const Color(0xFF111111)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, basePaint);

    final groovePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    for (double r = radius * 0.4; r < radius * 0.95; r += 3.5) {
      groovePaint.color = Colors.white.withOpacity(r % 7 == 0 ? 0.08 : 0.03);
      canvas.drawCircle(center, r, groovePaint);
    }

    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 0.5, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
