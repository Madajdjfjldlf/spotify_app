import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spotify/Pages/Register/Auth.dart/Auth.dart';

import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Common/widgets/MainScreen.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/Register/RegisterPage.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage> {
  // =========================
  // Controllers
  // =========================

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // =========================
  // Auth Service
  // =========================

  final AuthService _authService = AuthService();

  // =========================
  // Loading
  // =========================

  bool _isLoading = false;

  // =========================
  // Sign In
  // =========================

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // التحقق من الحقول
    if (email.isEmpty || password.isEmpty) {
      _showMessage('الرجاء إدخال الإيميل وكلمة المرور', Colors.orange);
      return;
    }

    // التحقق من صيغة الإيميل
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showMessage('الرجاء إدخال بريد إلكتروني صحيح', Colors.orange);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // تسجيل الدخول
      final response = await _authService.signIn(
        email: email,
        password: password,
      );

      if (!mounted) return;

      // التأكد من وجود المستخدم
      if (response.user != null) {
        _showMessage('تم تسجيل الدخول بنجاح!', Colors.green);

        // الانتقال إلى التطبيق الرئيسي (مع مسح المكدس)
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Bottombar()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      _showMessage(_getAuthErrorMessage(e), Colors.red);
    } catch (e) {
      if (!mounted) return;

      _showMessage('حدث خطأ غير متوقع', Colors.orange);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // =========================
  // Auth Error Messages
  // =========================

  String _getAuthErrorMessage(AuthException e) {
    final message = e.message.toLowerCase();

    if (message.contains('invalid login credentials')) {
      return 'الإيميل أو كلمة المرور غير صحيحة';
    }

    if (message.contains('email not confirmed')) {
      return 'يرجى تأكيد بريدك الإلكتروني أولاً';
    }

    if (message.contains('too many requests')) {
      return 'محاولات كثيرة، حاول مرة أخرى لاحقاً';
    }

    if (message.contains('user not found')) {
      return 'لا يوجد حساب بهذا الإيميل';
    }

    return 'فشل تسجيل الدخول: ${e.message}';
  }

  // =========================
  // SnackBar
  // =========================

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  // =========================
  // Dispose
  // =========================

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  // =========================
  // Build
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: Center(
          child: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
        ),
        hidarrow: !Navigator.canPop(context),
        hidIcons: !Navigator.canPop(context),
      ),

      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              _SigninText(),

              const SizedBox(height: 22),

              _Support(context),

              const SizedBox(height: 40),

              // =========================
              // Email
              // =========================
              _EnterUserNameOrEmail(context, _emailController),

              const SizedBox(height: 16),

              // =========================
              // Password
              // =========================
              _Enterpassword(context, _passwordController),

              const SizedBox(height: 5),

              // =========================
              // Recovery Password
              // =========================
              Align(
                alignment: Alignment.bottomLeft,

                child: TextButton(
                  onPressed: () {
                    // لاحقاً نسوي Forgot Password
                  },

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

              const SizedBox(height: 21),

              // =========================
              // Sign In Button
              // =========================
              _isLoading
                  ? const CircularProgressIndicator()
                  : ButtomNormal(
                      Title: 'Sign in',
                      onpress: _signIn,
                      height: 80,
                    ),

              const SizedBox(height: 21),

              // =========================
              // OR
              // =========================
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,

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

              const SizedBox(height: 30),

              // =========================
              // Google & Apple
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SvgPicture.asset('Assest/Vectors/Google.svg'),

                  const SizedBox(width: 58),

                  SvgPicture.asset(
                    'Assest/Vectors/Apple.svg',
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),

              // =========================
              // Register
              // =========================
              _register(context),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// Sign In Title
// =====================================================

Widget _SigninText() {
  return const Text(
    'Sign in',
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

// =====================================================
// Email
// =====================================================

Widget _EnterUserNameOrEmail(
  BuildContext context,
  TextEditingController controller,
) {
  return TextField(
    controller: controller,

    keyboardType: TextInputType.emailAddress,

    decoration: InputDecoration(
      hintText: 'enter email',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

// =====================================================
// Password
// =====================================================

Widget _Enterpassword(BuildContext context, TextEditingController controller) {
  return TextField(
    controller: controller,

    obscureText: true,

    decoration: InputDecoration(
      hintText: 'enter Password',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

// =====================================================
// Register
// =====================================================

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
            padding: const EdgeInsets.symmetric(horizontal: 5),

            minimumSize: Size.zero,

            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),

          onPressed: () {
            Navigator.push(
              context,

              MaterialPageRoute(builder: (context) => const RegisterPage()),
            );
          },

          child: const Text(
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

// =====================================================
// Support
// =====================================================

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
          padding: const EdgeInsets.symmetric(horizontal: 5),

          minimumSize: Size.zero,

          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
