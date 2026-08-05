import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/SettingPage/CustomSettingGroup.dart';
import 'package:spotify/Pages/AppPages/SettingPage/SettingCatogry.dart';
import 'package:spotify/Pages/AppPages/SettingPage/SettingData.dart';
import 'package:spotify/Pages/Register/signinpage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        Title: const Text(
          'Settings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Settingcatogry(
                  Title: 'Favorite',
                  Subtitle: 'Music',
                  icon: Icons.music_note,
                ),

                Settingcatogry(
                  Title: 'Last',
                  Subtitle: 'Music',
                  icon: Icons.last_page,
                ),
                Settingcatogry(
                  Title: 'Albums',
                  Subtitle: 'Music',
                  icon: Icons.music_note,
                ),
              ],
            ),
            const SizedBox(height: 16),
            // المجموعة الأولى: الحساب
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Account',
                  Subtitle: 'Username • Premium plans',
                  icon: Icons.person,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // المجموعة الثانية: المحتوى والعرض، الخصوصية، والتشغيل
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Content and display',
                  Subtitle: 'Canvas • Allow explicit content',
                  icon: Icons.music_note,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Privacy and social',
                  Subtitle: 'Private session • Public playlists',
                  icon: Icons.lock,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Playback',
                  Subtitle: 'Gapless playback • Autoplay',
                  icon: Icons.play_circle,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // المجموعة الثالثة: الإشعارات، التطبيقات، توفير البيانات، الجودة والإعلانات
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Notifications',
                  Subtitle: 'Push • Email',
                  icon: Icons.notifications,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Apps and devices',
                  Subtitle: 'Connected accounts • Google Maps',
                  icon: Icons.devices,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Data-saving and offline',
                  Subtitle: 'Data saver mode • Storage breakdown',
                  icon: Icons.download,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Media quality',
                  Subtitle:
                      'Wi-Fi streaming quality • Cellular streaming quality',
                  icon: Icons.bar_chart,
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Advertisements',
                  Subtitle: 'Tailored ads',
                  icon: Icons.campaign,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 16),

            // المجموعة الرابعة: حول التطبيق
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'About',
                  Subtitle: 'Version • Privacy Policy',
                  icon: Icons.info,
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return Signinpage();
                    },
                  ),
                );
              },
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Appcolor.Primary, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Login out',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Appcolor.Primary,
                        ),
                      ),
                      SvgPicture.asset(
                        'Assest/Vectors/out.svg',
                        color: Appcolor.Primary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
