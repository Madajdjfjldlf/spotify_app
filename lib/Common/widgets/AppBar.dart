import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/SettingPage/SettingPage.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({
    super.key,
    required this.Title,
    this.hidarrow = false,
    this.hidIcons = false,
  });

  final Widget? Title;
  final bool hidarrow;
  final bool hidIcons;

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

        // 1. الجهة اليسرى (تعتمد على حالة السهم)
        // إذا كان السهم ظاهراً (hidarrow = false)، يظهر السهم في الـ leading.
        // إذا كان السهم مخفياً (hidarrow = true)، يظهر زر البحث (Search) هنا.
        leading: hidarrow
            ? IconButton(
                onPressed: () {},
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
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
        leadingWidth: 48,

        // 2. الشعار في المنتصف تماماً
        title: Title ?? const Text(''),

        // 3. الجهة اليمنى (تعتمد أيضاً على حالة السهم)
        // إذا كان السهم مخفياً، تظهر أيقونة القائمة (more_vert).
        // إذا كان السهم ظاهراً، تكون فارغة لكي تحافظ على توازن الشعار في المنتصف.
        actions: [
          hidarrow
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SettingPage();
                        },
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                )
              : const SizedBox(
                  width: 48,
                ), // مساحة فارغة لمعادلة الـ leading عندما يكون السهم ظاهراً
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
