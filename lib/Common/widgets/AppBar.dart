import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/Search/SearchPage.dart';

import 'package:spotify/Pages/AppPages/SettingPage/SettingPages.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    required this.Title,
    this.hidarrow = false,
    this.hidIcons = false, // ✅ هذه الخاصية أصبحت مؤثرة الآن
  });

  final Widget? Title;
  final bool hidarrow;
  final bool hidIcons; // ✅ سيتم استخدامها لإخفاء جميع الأيقونات

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,

        // =========================
        // 1. الجهة اليسرى (leading)
        // =========================
        leading: hidIcons
            ? const SizedBox.shrink() // ✅ إذا أردنا إخفاء الكل، لا نضع شيئاً
            : (hidarrow
                  ? IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        'Assest/Vectors/Search 3.svg',
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    )
                  : IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? Colors.white.withOpacity(0.03)
                              : Colors.black.withOpacity(0.04),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'Assest/Vectors/Arrowback.svg',
                          fit: BoxFit.none,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    )),
        leadingWidth: hidIcons ? 0 : 48, // ✅ إذا أخفينا الكل، العرض يصبح 0
        // =========================
        // 2. الشعار في المنتصف
        // =========================
        title: Title ?? const Text(''),

        // =========================
        // 3. الجهة اليمنى (actions)
        // =========================
        actions: hidIcons
            ? [const SizedBox.shrink()] // ✅ إذا أردنا إخفاء الكل، لا نضع شيئاً
            : (hidarrow
                  ? [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.more_vert,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ]
                  : const [
                      SizedBox(width: 48), // مساحة فارغة لمعادلة الـ leading
                    ]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
