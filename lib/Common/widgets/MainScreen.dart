import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/Library/LibraryPage.dart';
import 'package:spotify/Pages/AppPages/Profile/PrfofilePage.dart';
import 'package:spotify/Pages/AppPages/Search/SearchPage.dart';
import 'package:spotify/Pages/AppPages/homepage/Homepage.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int _currentindex = 0;

  final List<Widget> _pages = [
    Homepage(),
    Librarypage(),
    Searchpage(),
    Prfofilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      extendBody: true, // تمدد محتوى الصفحة خلف الشريط
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_currentindex],
      ),
      bottomNavigationBar: SafeArea(
        bottom:
            true, // السماح للشريط بالنزول واستغلال مسافة الأمان في الآيفون بشكل صحيح
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF181818).withOpacity(0.85)
                      : Colors.white.withOpacity(0.85),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: BottomNavigationBar(
                  currentIndex: _currentindex,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  type: BottomNavigationBarType.fixed,
                  enableFeedback: false,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: Colors.green,
                  unselectedItemColor: isDarkMode
                      ? Colors.grey[400]
                      : Colors.grey[600],
                  onTap: (int index) {
                    setState(() {
                      _currentindex = index;
                    });
                  },
                  items: [
                    // 1. الرئيسية
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'Assest/Vectors/Home.svg',
                        height: _currentindex == 0 ? 35 : 28,
                        width: _currentindex == 0 ? 35 : 28,
                        colorFilter: ColorFilter.mode(
                          _currentindex == 0
                              ? Colors.green
                              : (isDarkMode
                                    ? Colors.grey[400]!
                                    : Colors.grey[600]!),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: '',
                    ),
                    // 2. المكتبة
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'Assest/Vectors/albumsMusic.svg',
                        height: _currentindex == 1 ? 35 : 28,
                        width: _currentindex == 1 ? 35 : 28,
                        colorFilter: ColorFilter.mode(
                          _currentindex == 1
                              ? Colors.green
                              : (isDarkMode
                                    ? Colors.grey[400]!
                                    : Colors.grey[600]!),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: '',
                    ),
                    // 3. البحث
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'Assest/Vectors/Search.svg',
                        height: _currentindex == 2 ? 35 : 28,
                        width: _currentindex == 2 ? 35 : 28,
                        colorFilter: ColorFilter.mode(
                          _currentindex == 2
                              ? Colors.green
                              : (isDarkMode
                                    ? Colors.grey[400]!
                                    : Colors.grey[600]!),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: '',
                    ),
                    // 4. الملف الشخصي
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'Assest/Vectors/Profile.svg',
                        height: _currentindex == 3 ? 35 : 28,
                        width: _currentindex == 3 ? 35 : 28,
                        colorFilter: ColorFilter.mode(
                          _currentindex == 3
                              ? Colors.green
                              : (isDarkMode
                                    ? Colors.grey[400]!
                                    : Colors.grey[600]!),
                          BlendMode.srcIn,
                        ),
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
