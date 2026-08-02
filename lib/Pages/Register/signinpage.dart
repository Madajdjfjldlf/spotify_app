import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/AppPages/Homepage.dart';
import 'package:spotify/Pages/Register/RegisterPage.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

class Signinpage extends StatelessWidget {
  const Signinpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: Center(
          child: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SigninText(),
              SizedBox(height: 22),
              _Support(context),
              SizedBox(height: 40),

              // استخدام TextField الحقيقي بدلاً من TextButton لتجنب المشاكل
              _EnterUserNameOrEmail(context),
              SizedBox(height: 16),
              _Enterpassword(context),
              SizedBox(height: 5),

              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Recovery password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 21),

              ButtomNormal(
                Title: 'Sign in',
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Homepage();
                      },
                    ),
                  );
                },
                height: 80,
              ),

              SizedBox(height: 21),

              Row(
                mainAxisSize: MainAxisSize
                    .min, // لجعل الـ Row يأخذ مساحة العناصر فقط بدلاً من التمدد الكامل
                crossAxisAlignment: CrossAxisAlignment
                    .center, // لضبط المحاذاة في المنتصف رأسياً
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      endIndent: 15,
                    ),
                  ),
                  Text(
                    'Or',
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.7,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      indent: 15,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('Assest/Vectors/Google.svg'),
                  SizedBox(width: 58),
                  SvgPicture.asset(
                    'Assest/Vectors/Apple.svg',
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),

              _register(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _SigninText() {
  return const Text(
    'Sign in',
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Widget _EnterUserNameOrEmail(context) {
  return TextField(
    decoration: InputDecoration(
      hintText: 'enter username or email',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _Enterpassword(context) {
  return TextField(
    decoration: InputDecoration(
      hintText: 'enter Password',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _register(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'not a member ?',
          style: TextStyle(
            fontSize: 14,
            color: context.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),

        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 5),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return RegisterPage();
                },
              ),
            );
          },
          child: Text(
            'register now',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xff288CE9),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _Support(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'If you need any support',
        style: TextStyle(
          fontSize: 14,
          color: context.isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),

      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 5,
          ), // إزالة المسافات الداخلية تماماً
          minimumSize:
              Size.zero, // إلغاء الحد الأدنى الافتراضي لعرض وارتفاع الزر
          tapTargetSize: MaterialTapTargetSize
              .shrinkWrap, // تقليص مساحة اللمس لتتطابق مع حجم النص
        ),
        child: const Text(
          'click here',
          style: TextStyle(
            fontSize: 14,
            color: Appcolor.Primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}
