import 'package:flutter/material.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class Settingcatogry extends StatelessWidget {
  const Settingcatogry({
    super.key,
    required this.Title,
    required this.Subtitle,
    required this.icon,
  });
  final String Title;
  final String Subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 140,
        width: 115,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xff121212)
              : const Color(0xffffffff),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Appcolor.Primary.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(icon, color: Appcolor.Primary),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                Title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
              Text(
                Subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 9,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
