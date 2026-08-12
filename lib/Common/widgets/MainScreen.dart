import 'dart:ui';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/Library/LibraryPage.dart';
import 'package:spotify/Pages/AppPages/Profile/PrfofilePage.dart';
import 'package:spotify/Pages/AppPages/Search/BrowsePage.dart';
import 'package:spotify/Pages/AppPages/Search/SearchPage.dart';
import 'package:spotify/Pages/AppPages/Search/browse_page.dart';
import 'package:spotify/Pages/AppPages/homepage/Homepage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

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
    Browsepage(),
    Prfofilepage(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.isDarkMode;

    // ✅ إزالة الحشوة السفلية التي يفرضها النظام (SafeArea)
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true, // 🔥 الأمر السحري: يكسر مسافة الأمان السفلية
      child: Scaffold(
        backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
        extendBody: true,
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
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF181818).withOpacity(0.85)
                      : Colors.white.withOpacity(0.85),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SizedBox(
                  height: 55,
                  child: BottomNavigationBar(
                    currentIndex: _currentindex,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    enableFeedback: false,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedItemColor: Appcolor.Primary,
                    unselectedItemColor: isDarkMode
                        ? Colors.grey[400]
                        : Colors.grey[600],
                    onTap: (int index) {
                      setState(() {
                        _currentindex = index;
                      });
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'Assest/Vectors/Home.svg',
                          height: _currentindex == 0 ? 28 : 24,
                          width: _currentindex == 0 ? 28 : 24,
                          colorFilter: ColorFilter.mode(
                            _currentindex == 0
                                ? Appcolor.Primary
                                : (isDarkMode
                                      ? Colors.grey[400]!
                                      : Colors.grey[600]!),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'Assest/Vectors/albumsMusic.svg',
                          height: _currentindex == 1 ? 28 : 24,
                          width: _currentindex == 1 ? 28 : 24,
                          colorFilter: ColorFilter.mode(
                            _currentindex == 1
                                ? Appcolor.Primary
                                : (isDarkMode
                                      ? Colors.grey[400]!
                                      : Colors.grey[600]!),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'Assest/Vectors/Search.svg',
                          height: _currentindex == 2 ? 28 : 24,
                          width: _currentindex == 2 ? 28 : 24,
                          colorFilter: ColorFilter.mode(
                            _currentindex == 2
                                ? Appcolor.Primary
                                : (isDarkMode
                                      ? Colors.grey[400]!
                                      : Colors.grey[600]!),
                            BlendMode.srcIn,
                          ),
                        ),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'Assest/Vectors/Profile.svg',
                          height: _currentindex == 3 ? 28 : 24,
                          width: _currentindex == 3 ? 28 : 24,
                          colorFilter: ColorFilter.mode(
                            _currentindex == 3
                                ? Appcolor.Primary
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
      ),
    );
  }
}
