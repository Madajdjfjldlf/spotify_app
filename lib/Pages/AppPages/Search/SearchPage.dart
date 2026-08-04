import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';

class Searchpage extends StatelessWidget {
  const Searchpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: []),
      ),
    );
  }
}
