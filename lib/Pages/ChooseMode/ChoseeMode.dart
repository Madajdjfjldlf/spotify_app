import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/ChooseMode/bloc/Them_Cubit.dart';
import 'package:spotify/Pages/Register/signup_login.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class Chooseemode extends StatelessWidget {
  const Chooseemode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assest/Images/Picture2_intro.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(color: Colors.black.withOpacity(0.15)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset('Assest/Vectors/Logo.svg'),
                  ),

                  const Spacer(), // لدفع النصوص إلى الأسفل

                  const Text(
                    'Choose mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 31),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // --- زر الـ Dark Mode (القمر) ---
                      Column(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 73,
                                width: 73,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff30393c,
                                  ).withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // تفعيل الـ Dark Mode هنا عند الضغط على القمر
                                    context.read<ThemeCubit>().updateTheme(
                                      ThemeMode.dark,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'Assest/Vectors/Moon.svg',
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Dark mode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Appcolor.Grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 60),

                      // --- زر الـ Light Mode (الشمس) ---
                      Column(
                        children: [
                          ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                height: 73,
                                width: 73,
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xff30393c,
                                  ).withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    // تفعيل الـ Light Mode هنا عند الضغط على الشمس
                                    context.read<ThemeCubit>().updateTheme(
                                      ThemeMode.light,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                    'Assest/Vectors/Sun 1.svg',
                                    fit: BoxFit.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 17),
                          const Text(
                            'Light mode',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Appcolor.Grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 68),
                  ButtomNormal(
                    Title: 'Continue',
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SigninOrLogin();
                          },
                        ),
                      );
                    },
                    height: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
