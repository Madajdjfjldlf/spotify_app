import 'package:flutter/material.dart';

class Settingdata {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  final bool isSwitch;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final Widget? trailing;

  Settingdata({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    required this.iconColor,

    this.isSwitch = false,
    this.switchValue,
    this.onSwitchChanged,
    this.trailing,
  });
}
