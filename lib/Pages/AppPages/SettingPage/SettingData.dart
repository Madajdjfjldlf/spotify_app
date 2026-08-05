import 'package:flutter/material.dart';

class Settingdata {
  final String title;
  final String Subtitle;
  final IconData icon;
  final VoidCallback onTap;

  Settingdata({
    required this.title,
    required this.Subtitle,
    required this.icon,
    required this.onTap,
  });
}
