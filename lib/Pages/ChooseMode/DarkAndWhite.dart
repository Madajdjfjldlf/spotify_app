import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Darkandwhite extends StatefulWidget {
  const Darkandwhite({super.key});

  @override
  State<Darkandwhite> createState() => _DarkandwhiteState();
}

bool Isdak = false;

class _DarkandwhiteState extends State<Darkandwhite> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          Isdak = !Isdak;
          print('is Dark');
        });
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 30, end: Isdak ? 40 : 30),
        duration: Duration(milliseconds: 300),
        builder: (context, size, child) {
          return SvgPicture.asset(
            Isdak ? 'Assest/Vectors/Moon.svg' : 'Assest/Vectors/Sun 1.svg',
            width: size,
            height: size,
          );
        },
      ),
    );
  }
}
