import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/MusicPage/NowplayingPage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class CdWidget extends StatefulWidget {
  final String imagePath;
  final double size;

  const CdWidget({Key? key, required this.imagePath, this.size = 150})
    : super(key: key);

  @override
  State<CdWidget> createState() => _CdWidgetState();
}

class _CdWidgetState extends State<CdWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double tiltX = 0;
  double tiltY = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(); // دوران مستمر
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(_) {
    setState(() {
      tiltX = 0.05;
      tiltY = -0.05;
      _controller.duration = const Duration(seconds: 2); // تسريع
      _controller.repeat();
    });
  }

  void _onTapUp(_) {
    setState(() {
      tiltX = 0;
      tiltY = 0;
      _controller.duration = const Duration(seconds: 6); // رجوع طبيعي
      _controller.repeat();
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Nowplayingpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..rotateX(tiltX)
          ..rotateY(tiltY),
        child: RotationTransition(
          turns: _controller,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// 🎵 صورة القرص
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// 🌑 Gradient عمق (Linear)
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),

                /// 🎧 خطوط Vinyl (داخلية)
                CustomPaint(size: Size(size, size), painter: _VinylPainter()),

                /// 🔘 QR في المنتصف

                /// ⚪ نقطة صغيرة
                Container(
                  width: size * 0.20,
                  height: size * 0.20,
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Appcolor.DarkBg
                        : Appcolor.LightBg,
                    shape: BoxShape.circle,
                  ),
                ),

                Positioned(
                  top: 20,
                  bottom: 0,
                  left: 20,

                  child: SvgPicture.asset(
                    'Assest/Vectors/Spotify logo.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 🎼 رسام الخطوط الداخلية (احترافي)
class _VinylPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.100)
      ..style = PaintingStyle.stroke;

    for (double i = center * 0.35; i < center; i += 3) {
      paint.strokeWidth = 0.6;
      canvas.drawCircle(Offset(center, center), i, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
