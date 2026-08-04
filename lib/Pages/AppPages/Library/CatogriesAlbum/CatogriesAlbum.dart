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
      padding: const EdgeInsets.only(left: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 180,
            width: 185,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // 1. الكونتينر الأسود الخلفي
                Positioned(
                  left:
                      60, // اجعله يلتصق باليمين أو يتحرك للداخل قليلاً حسب رغبتك
                  top: 0,
                  bottom: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 150,
                      width: 150, // مساواة العرض والارتفاع لضمان شكل الدائرة
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // جعل الشكل دائرياً
                        color: Theme.of(context).brightness == Brightness.dark
                            ? const Color(0xFF1C1B1B)
                            : const Color(0xFF1C1B1B),
                      ),
                    ),
                  ),
                ),

                // 2. صورة الألبوم الرئيسية في المقدمة
                Container(
                  height: 160,
                  width: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      // تم تصحيح طريقة استدعاء مسار الصورة
                      image: AssetImage(Photo),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
