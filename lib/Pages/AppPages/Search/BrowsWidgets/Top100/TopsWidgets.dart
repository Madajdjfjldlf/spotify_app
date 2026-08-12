import 'package:flutter/material.dart';
import 'package:spotify/Common/widgets/buttom/FavoritBottom.dart';

class Topswidgets extends StatelessWidget {
  const Topswidgets({
    super.key,
    required this.rank,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.songId,
    this.onTap,
  });

  final String rank;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String duration;
  final int songId;
  final VoidCallback? onTap;

  ImageProvider _getImageProvider() {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return NetworkImage(imageUrl);
    } else {
      return AssetImage(imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  rank,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: rank == '1'
                        ? const Color(0xFFFFD700)
                        : rank == '2'
                        ? const Color(0xFFC0C0C0)
                        : rank == '3'
                        ? const Color(0xFFCD7F32)
                        : (isDark ? Colors.white60 : Colors.grey.shade500),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: _getImageProvider(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white60 : Colors.black54,
              ),
            ),
            const SizedBox(width: 10),
            FavoriteIcon(songId: songId),
          ],
        ),
      ),
    );
  }
}
