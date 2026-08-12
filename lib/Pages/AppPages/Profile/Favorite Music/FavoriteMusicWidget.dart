import 'package:flutter/material.dart';

class Favoritemusicwidget extends StatelessWidget {
  const Favoritemusicwidget({
    super.key,
    required this.title,
    required this.subtite,
    required this.photo,
    this.onTap,
  });

  final String title;
  final String subtite;
  final String photo;
  final VoidCallback? onTap;

  ImageProvider _getImageProvider() {
    if (photo.startsWith('http://') ||
        photo.startsWith('https://')) {
      return NetworkImage(photo);
    }

    return AssetImage(photo);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 280,
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: _getImageProvider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtite,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}