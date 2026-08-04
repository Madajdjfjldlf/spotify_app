import 'package:flutter/material.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/MusicPage/NowplayingPage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class CdWidget extends StatelessWidget {
  final String imagePath;
  final double size;

  const CdWidget({Key? key, required this.imagePath, this.size = 150})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Nowplayingpage();
            },
          ),
        );
      },
      child: ClipOval(
        child: SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // الصورة بكامل الحجم
              Image.asset(
                imagePath,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),

              // الثقب في المنتصف مباشرة
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
            ],
          ),
        ),
      ),
    );
  }
}
