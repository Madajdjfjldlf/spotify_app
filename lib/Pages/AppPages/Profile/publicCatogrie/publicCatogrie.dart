import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/buttom/FavoritBottom.dart';

class Publiccatogrie extends StatelessWidget {
  const Publiccatogrie({
    super.key,
    required this.photo,
    required this.Title,
    required this.Subtitle,
    required this.Time,
    this.onTap,
  });

  final String photo;
  final String Title;
  final String Subtitle;
  final String Time;
  final VoidCallback? onTap;

  ImageProvider _getImageProvider() {
    if (photo.startsWith('http://') || photo.startsWith('https://')) {
      return NetworkImage(photo);
    } else {
      return AssetImage(photo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _getImageProvider(),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    Subtitle,
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

            // ✅ زر المفضلة القديم (بدون songId)
          ],
        ),
      ),
    );
  }
}
