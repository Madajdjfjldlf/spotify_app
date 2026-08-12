import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbum.dart';

class Catogriesalbumview extends StatelessWidget {
  const Catogriesalbumview({
    super.key,
    required this.albumsList,
    required String albumId,
  });

  final List<Map<String, dynamic>>
  albumsList; // ✅ تغيير النوع إلى dynamic لضمان استقبال البيانات من الـ API

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
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: albumsList.length,
        itemBuilder: (context, index) {
          final albuminfo = albumsList[index];

          // ✅ التحقق والتأكد من قراءة البيانات سواء كانت الحروف كبيرة أو صغيرة
          final String photo = (albuminfo['photo'] ?? albuminfo['Photo'] ?? '')
              .toString();
          final String title =
              (albuminfo['title'] ?? albuminfo['Title'] ?? 'ألبوم').toString();
          final String subtitle =
              (albuminfo['subtitle'] ?? albuminfo['Subtitle'] ?? 'فنان')
                  .toString();
          final String id = (albuminfo['id'] ?? albuminfo['albumId'] ?? '')
              .toString();

          debugPrint('🔍 Album: $title, ID: $id, Photo: $photo');

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
