import 'package:flutter/material.dart';

class Popularartistwidget extends StatelessWidget {
  const Popularartistwidget({
    super.key,
    required this.image,
    required this.ArtistName,
  });

  final String image;
  final String ArtistName;

  // ✅ دالة ذكية لتحديد نوع الصورة (شبكة أو محلية)
  ImageProvider _getImageProvider() {
    if (image.startsWith('http://') || image.startsWith('https://')) {
      return NetworkImage(image);
    } else {
      return AssetImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: _getImageProvider(), // ✅ دعم الشبكة والمحلي
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            ArtistName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
