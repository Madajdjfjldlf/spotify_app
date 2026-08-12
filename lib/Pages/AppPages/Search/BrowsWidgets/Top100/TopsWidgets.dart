import 'package:flutter/material.dart';
import 'package:spotify/Pages/AppPages/homepage/PlayList/FavoritBottom.dart';

class Topswidgets extends StatelessWidget {
  const Topswidgets({
    super.key,
    required this.rank,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.duration,
  });

  final String rank;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String duration;

  // ✅ دالة ذكية لتحديد نوع الصورة (شبكة أو محلية)
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // ✅ الرقم الترتيبي
          SizedBox(
            width: 24,
            child: Text(
              rank,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white60 : Colors.grey,
              ),
            ),
          ),
          const SizedBox(width: 6),

          // ✅ صورة الأغنية
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: _getImageProvider(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ✅ النصوص (العنوان والفنان)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
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

          // ✅ المدة
          Text(
            duration,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white60 : Colors.black54,
            ),
          ),
          const SizedBox(width: 12),

          // ✅ زر المفضلة
          const FavoriteIcon(),
        ],
      ),
    );
  }
}
