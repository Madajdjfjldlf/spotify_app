import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/Cdmusic.dart';
import 'package:spotify/Services/data_service.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';

class Cdmusicview extends StatelessWidget {
  const Cdmusicview({super.key});

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
        height: 160,
        child: Center(
          child: Text('لا توجد أغاني', style: TextStyle(color: Colors.white54)),
        ),
      );
    }

    return SizedBox(
      height: 160,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16, right: 16),
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          final song = songs[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CdWidget(
              imageUrl: song['image']!,
              title: song['title']!,
              artist: song['subtitle']!,
              size: 140,
              previewUrl: song['preview'] ?? '',
              onTap: () =>
                  _navigateToNowPlaying(context, song), // ✅ تمرير دالة الضغط
            ),
          );
        },
      ),
    );
  }
}
