import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/ChooseMode/DarkAndWhite.dart';
import 'package:spotify/Pages/ChooseMode/bloc/Them_Cubit.dart';
import 'package:spotify/Pages/Register/signup_login.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class Chooseemode extends StatefulWidget {
  const Chooseemode({super.key});

  @override
  State<Chooseemode> createState() => _ChooseemodeState();
}

class _ChooseemodeState extends State<Chooseemode> {
  bool isDark = false;

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
            // 🔹 Background
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assest/Images/Picture2_intro.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🔹 Overlay
            Container(color: Colors.black.withOpacity(0.15)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset('Assest/Vectors/Logo.svg'),
                  ),

                  const Spacer(),

                  const Text(
                    'Choose mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 31),

                  // 🔥 Toggle Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 🌙 DARK MODE
                      GestureDetector(
                        onTap: () {
                          setState(() => isDark = true);
                          context.read<ThemeCubit>().updateTheme(
                            ThemeMode.dark,
                          );
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  height: 73,
                                  width: 73,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xff30393c,
                                    ).withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(
                                        begin: 28,
                                        end: isDark ? 38 : 28,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOutBack,
                                      builder: (context, size, child) {
                                        return TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          tween: Tween(
                                            begin: 0,
                                            end: isDark ? 0.5 : 0,
                                          ),
                                          builder: (context, angle, child) {
                                            return Transform.rotate(
                                              angle: angle,
                                              child: AnimatedOpacity(
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                opacity: isDark ? 1 : 0.5,
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    isDark
                                                        ? Colors.white
                                                        : Colors.grey,
                                                    BlendMode.srcIn,
                                                  ),
                                                  child: isDark
                                                      ? Image.asset(
                                                          'Assest/Images/Moon.png',
                                                          width: size,
                                                          height: size,
                                                        )
                                                      : Image.asset(
                                                          'Assest/Images/Moon outline.png',
                                                          width: size,
                                                          height: size,
                                                        ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'Dark mode',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white : Appcolor.Grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 70),

                      // (إذا عندك Widget وسط خليها)

                      // ☀️ LIGHT MODE
                      GestureDetector(
                        onTap: () {
                          setState(() => isDark = false);
                          context.read<ThemeCubit>().updateTheme(
                            ThemeMode.light,
                          );
                        },
                        child: Column(
                          children: [
                            ClipOval(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 10,
                                  sigmaY: 10,
                                ),
                                child: Container(
                                  height: 73,
                                  width: 73,
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xff30393c,
                                    ).withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(
                                        begin: 28,
                                        end: !isDark ? 38 : 28,
                                      ),
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeOutBack,
                                      builder: (context, size, child) {
                                        return TweenAnimationBuilder<double>(
                                          duration: const Duration(
                                            milliseconds: 400,
                                          ),
                                          tween: Tween(
                                            begin: 0,
                                            end: isDark ? 0.5 : 0,
                                          ),
                                          builder: (context, angle, child) {
                                            return Transform.rotate(
                                              angle: angle,
                                              child: AnimatedOpacity(
                                                duration: const Duration(
                                                  milliseconds: 250,
                                                ),
                                                opacity: !isDark ? 1 : 0.5,
                                                child: ColorFiltered(
                                                  colorFilter: ColorFilter.mode(
                                                    !isDark
                                                        ? Colors.yellow
                                                        : Colors.grey,
                                                    BlendMode.srcIn,
                                                  ),
                                                  child: isDark
                                                      ? SvgPicture.asset(
                                                          'Assest/Vectors/Sun 1.svg',
                                                          width: size,
                                                          height: size,
                                                        )
                                                      : Image.asset(
                                                          'Assest/Images/Sun.png',
                                                          width: size,
                                                          height: size,
                                                        ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 17),
                            Text(
                              'Light mode',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: !isDark ? Colors.white : Appcolor.Grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 68),

                  // 🔘 Continue Button
                  ButtomNormal(
                    Title: 'Continue',
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SigninOrLogin(),
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
