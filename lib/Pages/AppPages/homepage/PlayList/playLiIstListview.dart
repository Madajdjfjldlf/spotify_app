import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/homepage/PlayList/PlayListwidget.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';
import 'package:spotify/Services/data_service.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    final songs = DataService.cachedTracks ?? [];

    if (songs.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            'لا توجد أغاني لعرضها',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        final song = songs[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Playlistwidget(
            title: song['title']!,
            subTitle: song['subtitle']!,
            Time: song['Time']!,
            songId: int.tryParse(song['songId'] ?? '0') ?? 0,
            onTap: () => _navigateToNowPlaying(context, song),
            onPlayTap: () => _navigateToNowPlaying(context, song),
          ),
        );
      },
    );
  }

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
}
