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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('Assest/Vectors/Play.svg'),
          ),
          SizedBox(width: 24),
          Column(
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                subTitle,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(width: 50),
          Text(
            Time,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),

          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('Assest/Vectors/Favorit.svg'),
          ),
        ],
      ),
    );
  }
}
