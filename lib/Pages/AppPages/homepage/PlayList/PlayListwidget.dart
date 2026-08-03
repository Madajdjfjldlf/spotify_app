import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Playlistwidget extends StatelessWidget {
  const Playlistwidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.Time,
  });

  final String title;
  final String subTitle;
  final String Time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // 1. زر التشغيل
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('Assest/Vectors/Play.svg'),
          ),
          const SizedBox(width: 12),

          // 2. النصوص (تأخذ المساحة المتاحة وتلتف إذا كانت طويلة)
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
                ),
                const SizedBox(height: 5),
                Text(
                  subTitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // 3. الوقت
          Text(
            Time,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 16),

          // 4. زر المفضلة
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('Assest/Vectors/Favorit.svg'),
          ),
        ],
      ),
    );
  }
}
