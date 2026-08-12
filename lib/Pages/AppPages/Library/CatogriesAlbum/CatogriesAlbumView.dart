import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbum.dart';

class Catogriesalbumview extends StatelessWidget {
  const Catogriesalbumview({super.key, required this.albumsList});

  final List<Map<String, dynamic>> albumsList;

  @override
  Widget build(BuildContext context) {
    if (albumsList.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'لا توجد ألبومات',
            style: TextStyle(color: Color(0xffffffff)),
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: albumsList.length,
        itemBuilder: (context, index) {
          final albuminfo = albumsList[index];

          final String photo = (albuminfo['photo'] ?? albuminfo['Photo'] ?? '')
              .toString();
          final String title =
              (albuminfo['Title'] ?? albuminfo['title'] ?? 'ألبوم').toString();
          final String subtitle =
              (albuminfo['Subtitle'] ?? albuminfo['subtitle'] ?? 'فنان')
                  .toString();
          final String id = (albuminfo['id'] ?? albuminfo['albumId'] ?? '')
              .toString();

          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Catogriesalbum(
              Photo: photo,
              Title: title,
              Subtitle: subtitle,
              albumId: id,
            ),
          );
        },
      ),
    );
  }
}
