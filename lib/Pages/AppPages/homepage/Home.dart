import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/homepage/PlayList/playLiIstListview.dart';
// تأكد أن اسم الملف صحيح

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // خلفية سوداء زي 디자인
      appBar: AppBar(
        title: const Text(
          'ديزر - الأغاني الشائعة',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        // 👈 هذي أهم نقطة عشان تمرير الصفحة مع shrinkWrap
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ممكن تحط أي ويدجت إضافية فوق القائمة (مثل Banner أو ترحيب)
            Text(
              '🔥 أفضل الأغاني الآن',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            PlaylistView(), // هنا قائمة الأغاني
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
