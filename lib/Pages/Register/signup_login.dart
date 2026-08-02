import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/Register/RegisterPage.dart';
import 'package:spotify/Pages/Register/signinpage.dart';

class SigninOrLogin extends StatelessWidget {
  const SigninOrLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppBar(Title: null),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset('Assest/Images/Bilie1Elish.png', height: 400),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset('Assest/Vectors/UnionDown.svg'),
          ),

          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset('Assest/Vectors/Union.svg'),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment:
                        Alignment.topCenter, // تم تصحيحها هنا بإضافة اسم الكلاس
                    child: SvgPicture.asset(
                      'Assest/Vectors/Logo.svg',
                      width: 235,
                      height: 71,
                    ),
                  ),
                  const SizedBox(height: 51),
                  const Text(
                    'Enjoy listening to music',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 21),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider ',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff797979),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      // استخدام Expanded لجعل الزر يأخذ النصف المتاح ولا يتسبب في حدوث Overflow
                      Expanded(
                        child: ButtomNormal(
                          Title: 'Register',
                          onpress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return RegisterPage();
                                },
                              ),
                            );
                          },
                          height: 73,
                        ),
                      ),
                      const SizedBox(width: 89),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Signinpage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
