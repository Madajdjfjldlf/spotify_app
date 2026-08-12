import 'package:flutter/cupertino.dart';
import 'package:spotify/Pages/AppPages/Profile/publicCatogrie/publicCatogrie.dart';

class Publiccatogrieview extends StatelessWidget {
  Publiccatogrieview({super.key});
  final List<Map<String, String>> infoList = [
    {
      'photo': 'Assest/Images/Profile songs/SongBilie.jpg',
      'Title': 'Dont Smile At Me',
      'Subtitle': 'Billie Eilish',
      'Time': '3:45',
    },
    {
      'photo': 'Assest/Images/Profile songs/As it was.jpg',
      'Title': 'As It Was',
      'Subtitle': 'Harry Styles',
      'Time': '2:47',
    },
    {
      'photo': 'Assest/Images/Profile songs/Super freak.jpg',
      'Title': 'Super Freaky Girl',
      'Subtitle': 'Nicki Minaj',
      'Time': '2:50',
    },
    {
      'photo': 'Assest/Images/Profile songs/Bad Hbit.jpg',
      'Title': 'Bad Habit',
      'Subtitle': 'Steve Lacy',
      'Time': '3:52',
    },
    {
      'photo': 'Assest/Images/Profile songs/Planet Here.jpg',
      'Title': 'Planet Her',
      'Subtitle': 'Doja Cat',
      'Time': '4:12',
    },
    {
      'photo': 'Assest/Images/Profile songs/sweetest.png',
      'Title': 'Sweetest Pie',
      'Subtitle': 'Megan Thee Stallion',
      'Time': '3:21',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // ✅ استخدم Column بدلاً من ListView
    // عشان ما يصير ListView داخل SingleChildScrollView = Overflow
    return Column(
      children: infoList.map((info) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Publiccatogrie(
            context,
            photo: info['photo']!,
            Title: info['Title']!,
            Subtitle: info['Subtitle']!,
            Time: info['Time']!,
          ),
        );
      }).toList(),
    );
  }
}
