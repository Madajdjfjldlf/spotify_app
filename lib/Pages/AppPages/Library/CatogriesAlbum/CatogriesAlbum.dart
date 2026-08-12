import 'package:flutter/material.dart';
import 'package:spotify/Pages/AlbumPage.dart/AlbumPage.dart';

class Catogriesalbum extends StatefulWidget {
  const Catogriesalbum({
    super.key,
    required this.Photo,
    required this.Title,
    required this.Subtitle,
    required this.albumId,
    this.previewUrl,
    this.songTitle,
    this.artistName,
  });

  final String Photo;
  final String Title;
  final String Subtitle;
  final String albumId;
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

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Albumpage(title: widget.Title, albumId: widget.albumId),
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ تم تقليل الارتفاع والعرض
            SizedBox(
              height: 150, // ✅ من 165 إلى 150
              width: 200, // ✅ من 230 إلى 200
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // 🎧 القرص
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 65), // ✅ من 75 إلى 65
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutBack,
                    builder: (context, value, child) {
                      return Positioned(
                        left: value,
                        top: 6,
                        child: child!,
                      ); // ✅ من 10 إلى 6
                    },
                    child: RotationTransition(
                      turns: _spinController,
                      child: SizedBox(
                        height: 140, // ✅ من 140 إلى 125
                        width: 125,
                        child: CustomPaint(
                          painter: _VinylPainter(),
                          child: Center(
                            child: Container(
                              width: 45, // ✅ من 50 إلى 45
                              height: 45,
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
                    height: 135, // ✅ من 150 إلى 135
                    width: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: _getImageProvider(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // ✅ النصوص بحجم مناسب
            SizedBox(
              width: 135,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.Title,
                      style: const TextStyle(
                        fontSize: 13, // ✅ من 14 إلى 13
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.Subtitle,
                      style: TextStyle(
                        fontSize: 11, // ✅ من 12 إلى 11
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
