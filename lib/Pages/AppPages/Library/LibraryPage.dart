import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart';

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
            const SizedBox(height: 20),
            _text('Recently played'),
            const SizedBox(height: 5),
            Catogriesalbumview(
              albumsList: [
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Echoes in the Dark',
                  'Subtitle': 'The Cinematic Orchestra',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Midnight Mirage',
                  'Subtitle': 'Luna Park',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Coffee & Rain',
                  'Subtitle': 'Acoustic Vibes',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Electric Pulse',
                  'Subtitle': 'Kyla Ray',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Window View',
                  'Subtitle': 'Lo-Fi Dreams',
                },
              ],
            ),
            SizedBox(height: 20),
            _text('Editor’s picks'),
            const SizedBox(height: 5),
            Catogriesalbumview(
              albumsList: [
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Echoes in the Dark',
                  'Subtitle': 'The Cinematic Orchestra',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Midnight Mirage',
                  'Subtitle': 'Luna Park',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Coffee & Rain',
                  'Subtitle': 'Acoustic Vibes',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Electric Pulse',
                  'Subtitle': 'Kyla Ray',
                },
                {
                  'photo': 'Assest/Images/Bilie3Elish.png',
                  'Title': 'Window View',
                  'Subtitle': 'Lo-Fi Dreams',
                },
              ],
            ),
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
