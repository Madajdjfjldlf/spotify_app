import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/Profile/publicCatogrie/publicCatogrieView.dart';
import 'package:spotify/ThemApp.dart/App_COlor.dart';

class Prfofilepage extends StatefulWidget {
  const Prfofilepage({super.key});

  @override
  State<Prfofilepage> createState() => _PrfofilepageState();
}

class _PrfofilepageState extends State<Prfofilepage> {
  String _userName = 'Guest';
  String _userEmail = 'No email';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (user == null) {
      setState(() {
        _isLoading = false;
        _userName = 'Guest';
        _userEmail = 'No email';
      });
      return;
    }

    final String fullName = user.userMetadata?['full_name'] as String? ?? '';
    final String displayName = fullName.isNotEmpty
        ? fullName
        : user.email?.split('@').first ?? 'Guest';

    setState(() {
      _userName = displayName;
      _userEmail = user.email ?? 'No email';
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final headerColor = context.isDarkMode
        ? const Color(0xFF1C1B1B)
        : Colors.white;

    final bodyColor = context.isDarkMode
        ? const Color(0xFF121212)
        : const Color(0xFFF2F2F2);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bodyColor,
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      // ✅ تغليف المحتوى داخل Container بلون الهيدر العلوي حتى لا ينكشف لون خلفية الشاشة عند السحب لأعلى
      body: Container(
        color: headerColor,
        child: ClipRect(
          child: CustomScrollView(
            // ✅ استخدام BouncingScrollPhysics
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // ─── الهيدر ───
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 140, bottom: 35),
                  decoration: BoxDecoration(
                    color: headerColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        height: 90,
                        width: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('Assest/Images/Avtar.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      _isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              _userName,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Appcolor.DarkGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                      const SizedBox(height: 5),
                      _isLoading
                          ? const SizedBox.shrink()
                          : Text(
                              _userEmail,
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white70
                                    : Appcolor.DarkGrey,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                      const SizedBox(height: 25),
                      _Following(context),
                    ],
                  ),
                ),
              ),

              // ─── باقي الشاشة كجزء منفصل بلون الـ bodyColor ───
              SliverToBoxAdapter(
                child: Container(
                  color: bodyColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      // ─── عنوان Public playlists ───
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          'Public playlists',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? Colors.white
                                : Appcolor.DarkGrey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ─── قائمة الـ Playlists ───
                      Publiccatogrieview(),

                      const SizedBox(height: 160),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Following(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '778',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.isDarkMode ? Colors.white : Appcolor.DarkGrey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Followers',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.isDarkMode
                      ? Colors.white70
                      : Appcolor.DarkGrey,
                ),
              ),
            ],
          ),
          const SizedBox(width: 70),
          Column(
            children: [
              Text(
                '938',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: context.isDarkMode ? Colors.white : Appcolor.DarkGrey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'Following',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.isDarkMode
                      ? Colors.white70
                      : Appcolor.DarkGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
