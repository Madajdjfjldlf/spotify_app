import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({super.key});

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFav = false;
  double scal = 1.0;

  void _onTap() async {
    setState(() => scal = 0.8);
    await Future.delayed(Duration(milliseconds: 120));
    setState(() {
      scal = 1.2;
      isFav = !isFav; // 👈 تغيير اللون
    });

    await Future.delayed(Duration(milliseconds: 120));
    setState(() => scal = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedScale(
        scale: scal,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: TweenAnimationBuilder(
          tween: Tween(begin: 0.0, end: isFav ? 1.0 : 0.0),
          duration: Duration(milliseconds: 250),
          builder: (context, value, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color.lerp(Appcolor.Grey, Appcolor.Primary, value)!,
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'Assest/Vectors/Favorit.svg',
                width: 26,
                height: 26,
              ),
            );
          },
        ),
      ),
    );
  }
}
