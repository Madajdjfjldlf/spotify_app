import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Publiccatogrie extends StatelessWidget {
  const Publiccatogrie(
    BuildContext context, {
    super.key,
    required this.photo,
    required this.Title,
    required this.Subtitle,
    required this.Time,
  });
  final String photo;
  final String Title;
  final String Subtitle;
  final String Time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(photo),
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
                ),
                const SizedBox(height: 5),
                Text(
                  Subtitle,
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
