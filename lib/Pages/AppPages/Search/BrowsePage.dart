import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/PopularartistView.dart';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/Top100/TopsMusicView.dart';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/TrendingSongs/TrendingView.dart';
import 'package:spotify/Pages/AppPages/Search/SearchPage.dart';

import 'package:spotify/ThemApp.dart/App_Color.dart';

class Browsepage extends StatelessWidget {
  const Browsepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _BarSearch(context),
            const SizedBox(height: 20),

            // ✅ قسم الفنانين المشهورين
            _buildSection(
              title: 'Popular Artists',
              child: const Popularartistview(),
            ),

            const SizedBox(height: 20),

            // ✅ قسم الأغاني الشائعة (Trending) - مثل الصورة
            _buildSection(title: 'Trending Now', child: const Trendingview()),
            const SizedBox(height: 20),

            _buildSection(title: 'Top 100 Music', child: const TopsMusicView()),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}

// ✅ شريط البحث
Widget _BarSearch(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SearchPage();
            },
          ),
        );
      },
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2A2A2A) : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            SvgPicture.asset(
              'Assest/Vectors/Search.svg',
              height: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              'Search artists, songs...',
              style: TextStyle(
                color: isDark ? Colors.white60 : Colors.black45,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
