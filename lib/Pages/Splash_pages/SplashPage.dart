import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Services/data_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:spotify/Common/widgets/MainScreen.dart';
import 'package:spotify/Pages/Register/RegisterPage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // ✅ 1. تحميل البيانات من Deezer API
    final success = await DataService.loadAllData();

    if (!mounted) return;

    if (!success) {
      // ❌ فشل تحميل البيانات → عرض رسالة خطأ
      setState(() {
        _isLoading = false;
        _errorMessage = DataService.errorMessage ?? 'فشل تحميل البيانات';
      });
      return;
    }

    // ✅ 2. التحقق من حالة المستخدم (Supabase)
    final user = Supabase.instance.client.auth.currentUser;

    // ✅ 3. الانتقال إلى الصفحة المناسبة
    if (user != null) {
      // المستخدم مسجل دخول → الصفحة الرئيسية
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Bottombar()),
      );
    } else {
      // المستخدم غير مسجل → صفحة التسجيل
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // شعار التطبيق
            SvgPicture.asset('Assest/Vectors/Logo.svg', height: 80),
          ],
        ),
      ),
    );
  }
}
