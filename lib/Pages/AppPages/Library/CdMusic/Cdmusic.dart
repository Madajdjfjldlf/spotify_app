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
      // استخدام Container دائري بقص المحتوى بداخله بدلاً من ClipOval
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: ClipPath(
          // أو قص الصورة باستخدام BoxDecoration مباشرة عبر الصورة
          child: Stack(
            alignment: Alignment.center,
            children: [
              // الصورة بكامل الحجم دائرية الشكل
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
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
