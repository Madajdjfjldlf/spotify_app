import 'package:flutter/cupertino.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/Cdmusic.dart';

class Cdmusicview extends StatelessWidget {
  Cdmusicview({super.key});

  // تم تصحيح المفتاح هنا ليصبح imagePath
  final List<Map<String, String>> infoList = [
    {'imagePath': 'Assest/Images/Bilie3Elish.png'},
    {'imagePath': 'Assest/Images/Profile songs/As it was.jpg'},
    {'imagePath': 'Assest/Images/Profile songs/Planet Here.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.only(left: 16),
        scrollDirection: Axis.horizontal,
        itemCount: infoList.length,
        itemBuilder: (context, index) {
          final info = infoList[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CdWidget(imagePath: info['imagePath']!),
          );
        },
      ),
    );
  }
}
