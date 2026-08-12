import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/buttom/FavoritBottom.dart';

class Playlistwidget extends StatelessWidget {
  const Playlistwidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.Time,
    required this.songId,
    this.onTap,
    this.onPlayTap,
  });

  final String title;
  final String subTitle;
  final String Time;
  final int songId;
  final VoidCallback? onTap;
  final VoidCallback? onPlayTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            GestureDetector(
              onTap: onPlayTap,
              child: Container(
                height: 37,
                width: 37,
                decoration: BoxDecoration(
                  color: context.isDarkMode
                      ? const Color(0xff2C2C2C)
                      : const Color(0xffE6E6E6),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'Assest/Vectors/Play.svg',
                    width: 17,
                    height: 17,
                    fit: BoxFit.none,
                    colorFilter: ColorFilter.mode(
                      context.isDarkMode
                          ? const Color(0xff959595)
                          : const Color(0xff555555),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    subTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              Time,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 32),
            FavoriteIcon(songId: songId),
          ],
        ),
      ),
    );
  }
}
