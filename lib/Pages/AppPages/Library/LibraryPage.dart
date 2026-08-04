import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/CdMusicView.dart';
import 'package:spotify/Pages/AppPages/Library/CdMusic/Cdmusic.dart';

class Librarypage extends StatelessWidget {
  const Librarypage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 25),
            _text('Recently played'),
            const SizedBox(height: 5),
            Catogriesalbumview(
              albumsList: [
                {
                  'photo': 'Assest/Images/Albums/Dreak.jpg',
                  'Title': 'Drake',
                  'Subtitle':
                      'Certified Lover Boy', // أو أي عنوان مناسب لـ Drake
                },
                {
                  'photo': 'Assest/Images/Albums/Michael.png',
                  'Title': 'Michael Jackson',
                  'Subtitle': 'Thriller',
                },
                {
                  'photo': 'Assest/Images/Albums/Bilie.jpg',
                  'Title': 'Billie Eilish',
                  'Subtitle': 'Happier Than Ever',
                },
              ],
            ),
            SizedBox(height: 5),
            _text('Editor’s picks'),
            const SizedBox(height: 5),
            Catogriesalbumview(
              albumsList: [
                {
                  'photo': 'Assest/Images/Albums/Radiohead.jpg',
                  'Title': 'Radiohead',
                  'Subtitle': 'OK Computer',
                },
                {
                  'photo': 'Assest/Images/Albums/Slow die.jpg',
                  'Title': 'Slowdive',
                  'Subtitle': 'Souvlaki',
                },
                {
                  'photo': 'Assest/Images/Albums/The Smiths.jpg',
                  'Title': 'The Smiths',
                  'Subtitle': 'The Queen Is Dead',
                },
              ],
            ),
            SizedBox(height: 5),
            _text('Music Of You'),
            const SizedBox(height: 20),

            Cdmusicview(),

            SizedBox(height: 30),
            _text('Otheres Albums'),
            const SizedBox(height: 5),
            Catogriesalbumview(
              albumsList: [
                {
                  'photo': 'Assest/Images/Albums/Cigert.jpg',
                  'Title': 'Lana Del Rey',
                  'Subtitle': 'Born to Die',
                },
                {
                  'photo': 'Assest/Images/Albums/Lana.jpg',
                  'Title': 'Cigarettes After Sex',
                  'Subtitle': 'Apocalypse',
                },
                {
                  'photo': 'Assest/Images/Albums/Ice.jpg',
                  'Title': 'Ice Spice',
                  'Subtitle': 'Like..?album',
                },
              ],
            ),

            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _text(String headerTitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Text(
            headerTitle,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          const Text(
            'See More',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
