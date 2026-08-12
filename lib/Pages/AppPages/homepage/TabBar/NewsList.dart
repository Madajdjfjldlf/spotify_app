import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Pages/AppPages/MusicPage/Nowplayingpage.dart';
import 'package:spotify/Services/data_service.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final songs = DataService.cachedTracks ?? [];

    if (songs.isEmpty) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: Text(
            'لا توجد أغاني لعرضها',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    final items = songs.take(20).toList();

    return SizedBox(
      height: 240,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.only(left: 24),
        itemBuilder: (context, index) {
          final song = items[index];
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
                              builder: (context) => Nowplayingpage(
                                title: song['title'],
                                artist: song['subtitle'],
                                imageUrl: song['image'],
                                previewUrl: song['preview'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              // ✅ الصورة ستظهر فوراً لأنها محملة مسبقاً
                              image: NetworkImage(song['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: 5,
                        child: Container(
                          height: 35,
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
                  song['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  song['subtitle']!,
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
