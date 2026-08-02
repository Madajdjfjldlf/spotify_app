import 'package:flutter/material.dart';

import 'package:spotify/Pages/AppPages/TabBar/NewsList.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart'; // تأكد من مسار الاستيراد الصحيح لديك

class CustomTabs extends StatelessWidget {
  final TabController tabController;

  const CustomTabs({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 1. الـ TabBar الذي أرسلته
        Align(
          alignment: Alignment.center,
          child: TabBar(
            controller: tabController,
            indicatorColor: Appcolor.Primary,
            isScrollable: true,
            dividerColor: Colors.transparent,
            labelColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text('News'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text('Video'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text('Artists'),
                ),
              ),
              Tab(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.0),
                  child: Text('Podcast'),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),

        // 2. ربط الـ TabBarView مع صفحة الـ News وباقي الصفحات
        SizedBox(
          height: 260,
          child: TabBarView(
            controller: tabController,
            children: const [
              NewsList(), // 👈 استدعاء صفحة الأخبار المنفصلة هنا
              Center(child: Text('Video Screen')),
              Center(child: Text('Artists Screen')),
              Center(child: Text('Podcast Screen')),
            ],
          ),
        ),
      ],
    );
  }
}
