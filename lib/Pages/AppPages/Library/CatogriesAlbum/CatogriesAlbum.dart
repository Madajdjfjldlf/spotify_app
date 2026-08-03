import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Catogriesalbum extends StatelessWidget {
  const Catogriesalbum({
    super.key,
    required this.Photo,
    required this.Title,
    required this.Subtitle,
  });

  final String Photo;
  final String Title;
  final String Subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 185,
            width: 185,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. الكونتينر الأسود الخلفي
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1C1B1B) // لون في الوضع الداكن
                          : const Color(0xFFE0E0E0), // لون في الوضع الفاتح
                    ),
                  ),
                ),

                // 2. صورة الألبوم الرئيسية في المقدمة
                Positioned(
                  left: 5,
                  bottom: 5,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        // تم تصحيح طريقة استدعاء مسار الصورة
                        image: AssetImage(Photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Title, // تم إزالة const لكونه متغيراً مرسلاً
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  Subtitle, // تم إزالة const لكونه متغيراً مرسلاً
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
