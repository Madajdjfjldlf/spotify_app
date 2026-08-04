import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// تأكد من صحة مسار الاستيراد هذا في مشروعك
import 'package:spotify/ThemApp.dart/App_Color.dart';

class Optionplaymusic extends StatefulWidget {
  const Optionplaymusic({super.key});

  @override
  State<Optionplaymusic> createState() => _OptionplaymusicState();
}

class _OptionplaymusicState extends State<Optionplaymusic> {
  // حالة زر التشغيل/الإيقاف المركزي (لا يتغير لونه عند الضغط بل حجمه وأيقونته)
  bool isopen = false;

  // متغيرات حالة لتعقب ما إذا كانت الأيقونات الأخرى "مضغوطة/مفعلة"
  bool isSpamActive = false;
  bool isPreviousActive = false;
  bool isNextActive = false;
  bool isShuffleActive = false;

  // دالة مساعدة للحصول على اللون المناسب للأيقونة بناءً على حالتها والثيم الحالي
  Color _getIconColor(BuildContext context, bool isActive) {
    if (isActive) {
      return Appcolor.Primary; // اللون عند التفعيل (الأخضر مثلاً)
    } else {
      // اللون الافتراضي عند عدم التفعيل بناءً على وضع الثيم (فاتح/غامق)
      return Theme.of(context).brightness == Brightness.dark
          ? Appcolor.Grey
          : Appcolor.DarkGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // 1. أيقونة Spam
          IconButton(
            onPressed: () {
              setState(() {
                isSpamActive = !isSpamActive; // عكس الحالة عند كل ضغطة
              });
            },
            icon: SvgPicture.asset(
              'Assest/Vectors/Spam.svg',
              height: 20,
              width: 20,
              color: _getIconColor(
                context,
                isSpamActive,
              ), // استخدام الدالة المساعدة
            ),
          ),

          // 2. أيقونة Previous
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'Assest/Vectors/Previous.svg',
              height: 20,
              width: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Appcolor.Grey
                  : Appcolor.DarkGrey,
            ),
          ),

          // 3. زر التشغيل المركزي (GestureDetector) - لم يتم تغيير منطقه بناءً على طلبك
          GestureDetector(
            onTap: () {
              setState(() {
                isopen = !isopen;
              });
            },
            child: Container(
              height: 72,
              width: 72,
              decoration: BoxDecoration(
                color: Appcolor.Primary, // لونه ثابت دائماً
                shape: BoxShape.circle,
              ),
              child: Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: isopen ? 30 : 20, end: isopen ? 20 : 30),
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  builder: (context, size, child) {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        isopen
                            ? 'Assest/Vectors/Play.svg'
                            : 'Assest/Vectors/stopVideo.svg',
                        key: ValueKey(isopen),
                        width: size * 1.3,
                        height: size * 1.3,
                        color: Colors.white, // لونه ثابت دائماً
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // 4. أيقونة Next
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'Assest/Vectors/Next.svg',
              height: 20,
              width: 20,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Appcolor.Grey
                  : Appcolor.DarkGrey,
            ),
          ),

          // 5. أيقونة Shuffle
          IconButton(
            onPressed: () {
              setState(() {
                isShuffleActive = !isShuffleActive; // عكس الحالة
              });
            },
            icon: SvgPicture.asset(
              'Assest/Vectors/Shuffle 2.svg',
              height: 20,
              width: 20,
              color: _getIconColor(context, isShuffleActive),
            ),
          ),
        ],
      ),
    );
  }
}
