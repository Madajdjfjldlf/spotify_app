import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class CdWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String artist;
  final double size;
  final String previewUrl;

  const CdWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.artist,
    this.size = 150,
    required this.previewUrl,
  }) : super(key: key);

  @override
  State<CdWidget> createState() => _CdWidgetState();
}

class _CdWidgetState extends State<CdWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double tiltX = 0;
  double tiltY = 0;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _onTapDown(_) {
    setState(() {
      tiltX = 0.02;
      tiltY = -0.02;
      _controller.duration = const Duration(milliseconds: 900);
      _controller.repeat();
    });

    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      _controller.duration = const Duration(seconds: 6);
      _controller.repeat();
    });
  }

  void _onTapUp(_) async {
    setState(() {
      tiltX = 0;
      tiltY = 0;
    });

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    // ✅ الانتقال إلى Nowplayingpage مع تمرير جميع البيانات
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: widget.title,
          artist: widget.artist,
          imageUrl: widget.imageUrl,
          previewUrl: widget.previewUrl, // ✅ تمرير preview
        ),
      ),
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
          ..setEntry(3, 2, 0.001)
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
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                /// 🌑 Gradient
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

                /// 🎧 خطوط داخلية
                CustomPaint(size: Size(size, size), painter: _VinylPainter()),

                /// 🔘 مركز القرص
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

                /// 🎵 شعار
                Positioned(
                  top: 20,
                  left: 40,
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

/// 🎼 رسم خطوط القرص
class _VinylPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;

    final paint = Paint()
      ..color = Colors.black.withOpacity(0.10)
      ..style = PaintingStyle.stroke;

    for (double i = center * 0.35; i < center; i += 3) {
      paint.strokeWidth = 0.6;
      canvas.drawCircle(Offset(center, center), i, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
