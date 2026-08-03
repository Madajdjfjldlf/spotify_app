import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/homepage/PlayList/PlayListwidget.dart';

class PlaylistView extends StatelessWidget {
  PlaylistView({super.key});
  final List<Map<String, String>> Songs = [
    {'title': 'As It Was', 'subtitle': 'Harry Styles', 'Time': '5:32'},
    {'title': 'Blinding Lights', 'subtitle': 'The Weeknd', 'Time': '3:20'},
    {'title': 'Shape of You', 'subtitle': 'Ed Sheeran', 'Time': '3:53'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Songs.length,
      itemBuilder: (context, index) {
        final song = Songs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Playlistwidget(
            title: song['title']!,
            subTitle: song['subtitle']!,
            Time: song['Time']!,
          ), // 👈 استدعاء الويدجت الخاص بالعنصر الفردي بشكل صحيح
        );
      },
    );
  }
}
