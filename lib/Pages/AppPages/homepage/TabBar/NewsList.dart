import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Pages/AppPages/MusicPage/NowplayingPage.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    // بيانات تجريبية
    final List<Map<String, String>> items = [
      {
        'title': 'Bad Guy',
        'subtitle': 'Billie Eilish',
        'image': 'Assest/Images/Songs/SongNewsFirst.jpg',
      },
      {
        'title': 'Scorpion',
        'subtitle': 'Drake',
        'image': 'Assest/Images/Songs/SongNewsSecond.jpg',
      },
      {
        'title': 'WHEN WE ALL FALL ASLEEP, WHERE DO WE GO?',
        'subtitle': 'Billie Eilish',
        'image': 'Assest/Images/Songs/SongNewsthree.jpg',
      },
    ];

    return SizedBox(
      height: 240,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 24),
        itemBuilder: (context, index) {
          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return Nowplayingpage();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              image: AssetImage(items[index]['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 5,
                        child: Container(
                          height: 35, // تكبير الزر قليلاً ليتطابق مع الصورة
                          width: 35,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'Assest/Vectors/Play.svg',
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  items[index]['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  items[index]['subtitle']!,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
