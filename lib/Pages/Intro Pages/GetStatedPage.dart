import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/Common/widgets/buttom/buttom_normal.dart';
import 'package:spotify/Pages/ChooseMode/ChoseeMode.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart'; // تأكد من صحة مسار الاستيراد

class Getstatedpage extends StatelessWidget {
  const Getstatedpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assest/Images/Picture1_intro.jpg'),
                  fit: BoxFit
                      .fill, // من الأفضل استخدام cover بدلاً من fill للحفاظ على أبعاد الصورة الأصلية بدون تشوه
                ),
              ),
            ),

            Container(color: Colors.black.withOpacity(0.15)),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SvgPicture.asset('Assest/Vectors/Logo.svg'),
                  ),

                  const Spacer(), // لدفع النصوص إلى الأسفل

                  const Text(
                    'Enjoy listening to music',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 26),

                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: Appcolor
                          .Grey, // تأكد من أن هذا المتغير موجود في ملف الألوان الخاص بك
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 37),
                  ButtomNormal(
                    Title: 'Get started',
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Chooseemode();
                          },
                        ),
                      );
                    },
                    height: null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
