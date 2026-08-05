import 'package:flutter/cupertino.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbum.dart';

class Catogriesalbumview extends StatelessWidget {
  const Catogriesalbumview({super.key, required this.albumsList});

  final List<Map<String, String>> albumsList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: albumsList.length,
        itemBuilder: (context, index) {
          final albuminfo = albumsList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 35),
            child: Catogriesalbum(
              Photo: albuminfo['photo'] ?? albuminfo['imageUrl'] ?? '',
              Title: albuminfo['Title'] ?? 'ألبوم',
              Subtitle: albuminfo['Subtitle'] ?? 'فنان',
            ),
          );
        },
      ),
    );
  }
}
