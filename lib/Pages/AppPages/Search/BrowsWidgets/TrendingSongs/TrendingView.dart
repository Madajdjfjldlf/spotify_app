import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/Search/BrowsWidgets/TrendingSongs/TrendingWidget.dart';
import 'package:spotify/Services/data_service.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class Trendingview extends StatelessWidget {
  const Trendingview({super.key});

  // ✅ دالة للتنقل إلى Nowplayingpage
  void _navigateToNowPlaying(BuildContext context, Map<String, String> song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Nowplayingpage(
          title: song['title'],
          artist: song['subtitle'],
          imageUrl: song['image'],
          previewUrl: song['preview'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ استخدام البيانات المخزنة من DataService
    final allTracks = DataService.cachedTracks ?? [];
    final songs = allTracks.take(10).toList(); // نأخذ أول 10 أغاني

    // ✅ حالة عدم وجود بيانات
    if (songs.isEmpty) {
      return const SizedBox(
        height: 230,
        child: Center(
          child: Text(
            'لا توجد أغاني حالياً',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Trendingwidget(
            imageUrl: song['image']!,
            title: song['title']!,
            subtitle: song['subtitle']!,
            previewUrl: song['preview']!,
            onTap: () => _navigateToNowPlaying(context, song),
          );
        },
      ),
    );
  }
}
