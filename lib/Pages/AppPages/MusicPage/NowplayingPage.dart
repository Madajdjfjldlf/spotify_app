import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Library/CatogriesAlbum/CatogriesAlbumView.dart';
import 'package:spotify/Pages/AppPages/homepage/PlayList/playLiIstListview.dart';
import 'package:spotify/Pages/AppPages/MusicPage/optionplaymusic.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

class Nowplayingpage extends StatelessWidget {
  const Nowplayingpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              _songPhoto(context),

              // سحب المحتوى للأعلى لتقليل المسافة تحت الصورة الكبيرة
              Transform.translate(
                offset: const Offset(0, -50),
                child: Column(
                  children: [
                    _textSong(),
                    const SizedBox(height: 20),
                    _songPlayerBar(),
                    const SizedBox(height: 25),
                    Optionplaymusic(),
                    const SizedBox(height: 10),
                    _songsetting(context),
                    SizedBox(height: 20),
                    _OfMusical(),

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Album',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Catogriesalbumview(
                      albumsList: [
                        {
                          'photo': 'Assest/Images/Albums/Bilie.jpg',
                          'Title': 'Billie Eilish',
                          'Subtitle': 'Happier Than Ever',
                        },
                        {
                          'photo': 'Assest/Images/Albums/Bilie 2.jpg',
                          'Title': 'Hit Me Hard and Soft',
                          'Subtitle': 'Billie Eilish',
                        },
                        {
                          'photo': 'Assest/Images/Albums/Bilie 3.jpg',
                          'Title': 'When We All Fall Asleep',
                          'Subtitle': 'Where Do We Go?',
                        },
                      ],
                    ),
                    SizedBox(height: 20),
                    _Songs(),
                    SizedBox(height: 10),
                    PlaylistView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _songPhoto(BuildContext context) {
  return Container(
    height: 500, // تم تكبير حجم الصورة لتصبح أكبر وأوضح
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      image: const DecorationImage(
        image: AssetImage('Assest/Images/NowPlaying.png'),
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _textSong() {
  return Padding(
    padding: const EdgeInsets.only(right: 30, left: 30),
    child: Row(
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bad Guy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              'Billie Eilish',
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Heart.svg',
            height: 26,
            width: 26,
          ),
        ),
      ],
    ),
  );
}

Widget _songPlayerBar() {
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),

    child: Column(
      children: [
        Slider(
          value: 2.25,
          min: 0.0,
          max: 4.02,
          activeColor: Colors.black,
          inactiveColor: Colors.grey.shade300,
          onChanged: (value) {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('2:25', style: TextStyle(fontSize: 12, color: Colors.grey)),
              Text('4:02', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _optionSong(dynamic context) {
  return Padding(
    padding: const EdgeInsets.only(right: 10, left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Spam.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Previous.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        GestureDetector(
          child: Container(
            height: 72,
            width: 72,
            decoration: BoxDecoration(
              color: Appcolor.Primary,
              borderRadius: BorderRadius.circular(40),
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'Assest/Vectors/Pause.svg',
                fit: BoxFit.none,
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Next.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Shuffle 2.svg',
            height: 20,
            width: 20,
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
      ],
    ),
  );
}

Widget _songsetting(dynamic context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(
            'Assest/Vectors/Dvecies.png',
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,

            height: 20,
            width: 20,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/playListIcon.svg',

            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
        SizedBox(width: 2),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'Assest/Vectors/Share.svg',
            color: Theme.of(context).brightness == Brightness.dark
                ? Appcolor.Grey
                : Appcolor.DarkGrey,
          ),
        ),
      ],
    ),
  );
}

Widget _OfMusical() {
  return Align(
    alignment: Alignment.center,
    child: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis adipiscing vestibulum orci enim, nascetur vitae ',
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _Songs() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Row(
      children: [
        Text(
          'Playlist',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(
          'See More',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
