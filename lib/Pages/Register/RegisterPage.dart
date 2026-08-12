import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Common/widgets/MainScreen.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/Register/Auth.dart/Auth.dart';
import 'package:spotify/Pages/Register/signinpage.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (_fullNameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty ||
        _passwordController.text.isEmpty) {
      _showMessage('الرجاء ملء جميع الحقول', Colors.orange);
      return;
    }

    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      _showMessage('الرجاء إدخال بريد إلكتروني صحيح', Colors.orange);
      return;
    }

    if (password.length < 6) {
      _showMessage('كلمة المرور يجب أن تكون 6 أحرف على الأقل', Colors.orange);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await _authService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (!mounted) return;

      if (response.user != null) {
        // ✅ تحديث الاسم في user_metadata بعد التسجيل مباشرة
        await _authService.updateUserProfile(fullName: fullName);
      }

      if (response.session == null) {
        _showMessage(
          'تم إنشاء الحساب! تحقق من بريدك الإلكتروني لتفعيل الحساب.',
          Colors.green,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Signinpage()),
        );
        return;
      }

      _showMessage('تم إنشاء الحساب بنجاح!', Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Bottombar()),
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      _showMessage('فشل التسجيل: ${e.message}', Colors.red);
    } catch (e) {
      if (!mounted) return;
      _showMessage('حدث خطأ غير متوقع: $e', Colors.orange);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
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
              _TitlePage(),
              const SizedBox(height: 22),
              _Support(context),
              const SizedBox(height: 40),
              _fullname(context, _fullNameController),
              const SizedBox(height: 16),
              _Email(context, _emailController),
              const SizedBox(height: 16),
              _passowrd(context, _passwordController),
              const SizedBox(height: 21),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ButtomNormal(
                      Title: 'Create Account',
                      onpress: _signUp,
                      height: 80,
                    ),
              const SizedBox(height: 21),
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
              _signin(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _TitlePage() {
  return const Text(
    'Register',
    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    textAlign: TextAlign.center,
  );
}

Widget _fullname(BuildContext context, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: 'full name',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _Email(BuildContext context, TextEditingController controller) {
  return TextField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Enter email',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _passowrd(BuildContext context, TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
    ).applyDefaults(Theme.of(context).inputDecorationTheme),
  );
}

Widget _signin(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 40),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Do you have an account?',
          style: TextStyle(
            fontSize: 14,
            color: context.isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Signinpage()),
            );
          },
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            child: Text(
              'sign In',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff288CE9),
                fontWeight: FontWeight.w500,
              ),
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
