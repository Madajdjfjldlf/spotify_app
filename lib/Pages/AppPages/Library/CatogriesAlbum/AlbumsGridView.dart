import 'package:flutter/cupertino.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbum.dart';

class Catogriesalbumview extends StatelessWidget {
  const Catogriesalbumview({super.key, required this.albumsList});

  final List<Map<String, String>> albumsList;

  @override
  Widget build(BuildContext context) {
    if (albumsList.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'لا توجد ألبومات',
            style: TextStyle(color: Color(0xffffff)),
          ),
        ),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: albumsList.length,
        itemBuilder: (context, index) {
          final albuminfo = albumsList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Catogriesalbum(
              Photo: albuminfo['photo'] ?? '',
              Title: albuminfo['Title'] ?? 'ألبوم',
              Subtitle: albuminfo['Subtitle'] ?? 'فنان',
            ),
          );
        },
      ),
    );
  }
}
