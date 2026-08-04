import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Profile/publicCatogrie/publicCatogrieView.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

class Prfofilepage extends StatelessWidget {
  const Prfofilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero, // إزالة المسافة الفارغة من الأعلى
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // ضبط المسافة من الأعلى لتكون أسفل الـ AppBar مباشرة
              padding: const EdgeInsets.only(top: 110, bottom: 25),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Color(0xFF1C1B1B) : Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(70),
                  bottomRight: Radius.circular(70),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 90,
                    width: 90,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('Assest/Images/Avtar.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'A_2b_c',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : Appcolor.DarkGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'bbshs2@gmail.com',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white70
                          : Appcolor.DarkGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 25),
                  _Following(context),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Public playlists',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode
                        ? Colors.white
                        : Appcolor.DarkGrey,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Publiccatogrieview(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

Widget _Following(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 70),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              '778',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Appcolor.DarkGrey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Followers',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.isDarkMode ? Colors.white70 : Appcolor.DarkGrey,
              ),
            ),
          ],
        ),
        const SizedBox(width: 70),
        Column(
          children: [
            Text(
              '938',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.isDarkMode ? Colors.white : Appcolor.DarkGrey,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Following',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.isDarkMode ? Colors.white70 : Appcolor.DarkGrey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
