import 'package:flutter/material.dart';

class ButtomNormal extends StatelessWidget {
  const ButtomNormal({
    super.key,
    required this.Title,
    required this.onpress,
    required this.height,
  });
  final String Title;
  final double? height;
  final VoidCallback onpress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        splashFactory: NoSplash.splashFactory, // إلغاء الوميض تماماً
        shadowColor: Colors.transparent,

        minimumSize: Size.fromHeight(height ?? 80),
        foregroundColor: Colors.white,
      ),
      child: Text(Title),
    );
  }
}
