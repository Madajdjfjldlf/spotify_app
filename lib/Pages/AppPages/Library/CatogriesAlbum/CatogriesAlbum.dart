import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class Catogriesalbum extends StatefulWidget {
  const Catogriesalbum({
    super.key,
    required this.Photo,
    required this.Title,
    required this.Subtitle,
  });

  final String Photo; // الآن هو رابط URL وليس مسار محلي
  final String Title;
  final String Subtitle;

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

  Future<void> _onTap() async {
    setState(() => _isPressed = true);
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() => _isPressed = false);
    await Future.delayed(const Duration(milliseconds: 120));
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Nowplayingpage()),
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
                  /// 🎧 القرص
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
                                  image: NetworkImage(widget.Photo), // ✅ تغيير
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

                  /// 🎵 الغلاف (الصورة الكبيرة)
                  Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: NetworkImage(widget.Photo), // ✅ تغيير
                        fit: BoxFit.cover,
                      ),
                    ),
                    // إذا فشل تحميل الصورة نعرض أيقونة افتراضية
                    child: widget.Photo.isEmpty
                        ? Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.album,
                              color: Colors.white54,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.Title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.Subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 🎼 رسم القرص (بدون تغيير)
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
