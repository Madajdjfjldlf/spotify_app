import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/Pages/AppPages/SettingPage/CustomSettingGroup.dart';
import 'package:spotify/Pages/AppPages/SettingPage/SettingData.dart';
import 'package:spotify/Pages/ChooseMode/bloc/Them_Cubit.dart';
import 'package:spotify/Pages/Register/signinpage.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailNotifications = false;
  bool _gaplessPlayback = true;
  bool _crossfade = false;
  bool _explicitContent = true;
  bool _dataSaver = false;
  bool _smartShuffle = true;
  bool _canvasEnabled = true;
  bool _carMode = false;
  double _crossfadeSeconds = 0;
  double _storageUsed = 2.4;

  @override
  Widget build(BuildContext context) {
    var isDark = context.isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black45;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? Appcolor.DarkBg : Appcolor.LightBg,
      appBar: BasicAppBar(
        Title: Text(
          'Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Profile Header ───
            _ProfileHeader(
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            const SizedBox(height: 24),

            // ─── Account ───
            _SectionTitle(title: 'Account', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Profile Information',
                  subtitle: 'Edit your name, email, avatar',
                  icon: Icons.person_outline_rounded,
                  iconColor: Appcolor.Primary,
                  iconBgColor: isDark
                      ? Appcolor.Primary.withOpacity(0.15)
                      : Appcolor.Primary.withOpacity(0.12),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Security',
                  subtitle: 'Password, 2FA, devices',
                  icon: Icons.lock_outline_rounded,
                  iconColor: const Color(0xFFFF6B6B),
                  iconBgColor: isDark
                      ? const Color(0xFFFF6B6B).withOpacity(0.15)
                      : const Color(0xFFFF6B6B).withOpacity(0.12),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Privacy',
                  subtitle: 'Manage your data & permissions',
                  icon: Icons.privacy_tip_outlined,
                  iconColor: const Color(0xFF667EEA),
                  iconBgColor: isDark
                      ? const Color(0xFF667EEA).withOpacity(0.15)
                      : const Color(0xFF667EEA).withOpacity(0.12),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Devices ───
            _SectionTitle(title: 'Devices', isDark: isDark),
            const SizedBox(height: 12),
            _DevicesCard(
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
            ),

            const SizedBox(height: 24),

            // ─── Playback ───
            _SectionTitle(title: 'Playback', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Streaming Quality',
                  subtitle: 'Very High (320 kbps)',
                  icon: Icons.high_quality_outlined,
                  iconColor: const Color(0xFFFFA07A),
                  iconBgColor: isDark
                      ? const Color(0xFFFFA07A).withOpacity(0.15)
                      : const Color(0xFFFFA07A).withOpacity(0.12),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: subTextColor,
                    size: 20,
                  ),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Smart Shuffle',
                  subtitle: 'AI-powered song recommendations',
                  icon: Icons.shuffle_rounded,
                  iconColor: const Color(0xFFDDA0DD),
                  iconBgColor: isDark
                      ? const Color(0xFFDDA0DD).withOpacity(0.15)
                      : const Color(0xFFDDA0DD).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _smartShuffle,
                  onSwitchChanged: (v) => setState(() => _smartShuffle = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Data Saver',
                  subtitle: 'Reduce data usage while streaming',
                  icon: Icons.wifi_tethering_outlined,
                  iconColor: const Color(0xFF4ECDC4),
                  iconBgColor: isDark
                      ? const Color(0xFF4ECDC4).withOpacity(0.15)
                      : const Color(0xFF4ECDC4).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _dataSaver,
                  onSwitchChanged: (v) => setState(() => _dataSaver = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Crossfade',
                  subtitle: 'Smooth transition between songs',
                  icon: Icons.merge_type_rounded,
                  iconColor: const Color(0xFFFFE66D),
                  iconBgColor: isDark
                      ? const Color(0xFFFFE66D).withOpacity(0.15)
                      : const Color(0xFFFFE66D).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _crossfade,
                  onSwitchChanged: (v) => setState(() => _crossfade = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Gapless Playback',
                  subtitle: 'No silence between tracks',
                  icon: Icons.music_note_outlined,
                  iconColor: const Color(0xFF4ECDC4),
                  iconBgColor: isDark
                      ? const Color(0xFF4ECDC4).withOpacity(0.15)
                      : const Color(0xFF4ECDC4).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _gaplessPlayback,
                  onSwitchChanged: (v) => setState(() => _gaplessPlayback = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Allow Explicit Content',
                  subtitle: 'Show songs with explicit lyrics',
                  icon: Icons.explicit_outlined,
                  iconColor: const Color(0xFFFF6B6B),
                  iconBgColor: isDark
                      ? const Color(0xFFFF6B6B).withOpacity(0.15)
                      : const Color(0xFFFF6B6B).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _explicitContent,
                  onSwitchChanged: (v) => setState(() => _explicitContent = v),
                  onTap: () {},
                ),
              ],
            ),
            // Crossfade Slider
            if (_crossfade)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 2),
                padding: const EdgeInsets.fromLTRB(72, 8, 20, 20),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Duration',
                          style: TextStyle(
                            color: subTextColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${_crossfadeSeconds.toInt()}s',
                          style: const TextStyle(
                            color: Appcolor.Primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Appcolor.Primary,
                        inactiveTrackColor: isDark
                            ? const Color(0xFF3A3A3A)
                            : Colors.grey.shade200,
                        thumbColor: Appcolor.Primary,
                        overlayColor: Appcolor.Primary.withOpacity(0.2),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: _crossfadeSeconds,
                        min: 0,
                        max: 12,
                        divisions: 12,
                        onChanged: (v) => setState(() => _crossfadeSeconds = v),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 24),

            // ─── Experience ───
            _SectionTitle(title: 'Experience', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Canvas',
                  subtitle: 'Short looping visuals on Now Playing',
                  icon: Icons.auto_awesome_rounded,
                  iconColor: const Color(0xFFFF6B6B),
                  iconBgColor: isDark
                      ? const Color(0xFFFF6B6B).withOpacity(0.15)
                      : const Color(0xFFFF6B6B).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _canvasEnabled,
                  onSwitchChanged: (v) => setState(() => _canvasEnabled = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Car Mode',
                  subtitle: 'Simplified UI while driving',
                  icon: Icons.directions_car_rounded,
                  iconColor: const Color(0xFF667EEA),
                  iconBgColor: isDark
                      ? const Color(0xFF667EEA).withOpacity(0.15)
                      : const Color(0xFF667EEA).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _carMode,
                  onSwitchChanged: (v) => setState(() => _carMode = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Sleep Timer',
                  subtitle: 'Stop playback after a set time',
                  icon: Icons.nights_stay_rounded,
                  iconColor: const Color(0xFFFFA07A),
                  iconBgColor: isDark
                      ? const Color(0xFFFFA07A).withOpacity(0.15)
                      : const Color(0xFFFFA07A).withOpacity(0.12),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFA07A).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Off',
                      style: TextStyle(
                        color: Color(0xFFFFA07A),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Notifications ───
            _SectionTitle(title: 'Notifications', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Push Notifications',
                  subtitle: 'New releases, playlists & more',
                  icon: Icons.notifications_none_rounded,
                  iconColor: Appcolor.Primary,
                  iconBgColor: isDark
                      ? Appcolor.Primary.withOpacity(0.15)
                      : Appcolor.Primary.withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _pushNotifications,
                  onSwitchChanged: (v) =>
                      setState(() => _pushNotifications = v),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Email Updates',
                  subtitle: 'Weekly digest & promotions',
                  icon: Icons.email_outlined,
                  iconColor: const Color(0xFF87CEEB),
                  iconBgColor: isDark
                      ? const Color(0xFF87CEEB).withOpacity(0.15)
                      : const Color(0xFF87CEEB).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _emailNotifications,
                  onSwitchChanged: (v) =>
                      setState(() => _emailNotifications = v),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Appearance ───
            _SectionTitle(title: 'Appearance', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Dark Mode',
                  subtitle: 'Toggle between light & dark theme',
                  icon: Icons.dark_mode_outlined,
                  iconColor: const Color(0xFF667EEA),
                  iconBgColor: isDark
                      ? const Color(0xFF667EEA).withOpacity(0.15)
                      : const Color(0xFF667EEA).withOpacity(0.12),
                  isSwitch: true,
                  switchValue: _darkMode,
                  onSwitchChanged: (v) {
                    setState(() {
                      _darkMode = v;
                    });
                    context.read<ThemeCubit>().updateTheme(
                      v ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Language',
                  subtitle: 'English (US)',
                  icon: Icons.language_rounded,
                  iconColor: const Color(0xFFFFA07A),
                  iconBgColor: isDark
                      ? const Color(0xFFFFA07A).withOpacity(0.15)
                      : const Color(0xFFFFA07A).withOpacity(0.12),
                  trailing: Icon(
                    Icons.chevron_right_rounded,
                    color: subTextColor,
                    size: 20,
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Storage ───
            _SectionTitle(title: 'Storage', isDark: isDark),
            const SizedBox(height: 12),
            _StorageCard(
              isDark: isDark,
              textColor: textColor,
              subTextColor: subTextColor,
              usedGB: _storageUsed,
              totalGB: 16.0,
            ),

            const SizedBox(height: 24),

            // ─── Social ───
            _SectionTitle(title: 'Social', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Share Profile',
                  subtitle: 'Show QR code for your profile',
                  icon: Icons.qr_code_rounded,
                  iconColor: Appcolor.Primary,
                  iconBgColor: isDark
                      ? Appcolor.Primary.withOpacity(0.15)
                      : Appcolor.Primary.withOpacity(0.12),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Listening Together',
                  subtitle: 'Start a group listening session',
                  icon: Icons.group_add_outlined,
                  iconColor: const Color(0xFF4ECDC4),
                  iconBgColor: isDark
                      ? const Color(0xFF4ECDC4).withOpacity(0.15)
                      : const Color(0xFF4ECDC4).withOpacity(0.12),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4ECDC4).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'New',
                      style: TextStyle(
                        color: Color(0xFF4ECDC4),
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Support ───
            _SectionTitle(title: 'Support', isDark: isDark),
            const SizedBox(height: 12),
            CustomSettingGroup(
              items: [
                Settingdata(
                  title: 'Help Center',
                  subtitle: 'FAQs, troubleshooting guides',
                  icon: Icons.help_outline_rounded,
                  iconColor: const Color(0xFF87CEEB),
                  iconBgColor: isDark
                      ? const Color(0xFF87CEEB).withOpacity(0.15)
                      : const Color(0xFF87CEEB).withOpacity(0.12),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'Contact Us',
                  subtitle: 'Get in touch with support',
                  icon: Icons.chat_bubble_outline_rounded,
                  iconColor: Appcolor.Primary,
                  iconBgColor: isDark
                      ? Appcolor.Primary.withOpacity(0.15)
                      : Appcolor.Primary.withOpacity(0.12),
                  onTap: () {},
                ),
                Settingdata(
                  title: 'About',
                  subtitle: 'Version 2.4.1 • Terms & Privacy Policy',
                  icon: Icons.info_outline_rounded,
                  iconColor: const Color(0xFFFFE66D),
                  iconBgColor: isDark
                      ? const Color(0xFFFFE66D).withOpacity(0.15)
                      : const Color(0xFFFFE66D).withOpacity(0.12),
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 32),

            // ─── Logout ───
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Signinpage()),
                );
              },
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B6B).withOpacity(0.1),
                  border: Border.all(
                    color: const Color(0xFFFF6B6B).withOpacity(0.3),
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'Assest/Vectors/out.svg',
                      color: const Color(0xFFFF6B6B),
                      height: 18,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Log Out',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Color(0xFFFF6B6B),
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────────────────────
// WIDGETS
// ───────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final Color subTextColor;

  const _ProfileHeader({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('Assest/Images/Avtar.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF2A2A2A)
                    : const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.edit_outlined, color: textColor, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final bool isDark;

  const _SectionTitle({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.3,
      ),
    );
  }
}

class _DevicesCard extends StatelessWidget {
  final bool isDark;
  final Color textColor;
  final Color subTextColor;
  final Color activeColor; // ← لون Active
  final Color inactiveColor; // ← لون Inactive

  const _DevicesCard({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    this.activeColor = Appcolor.Primary, // افتراضي
    this.inactiveColor = const Color(0xFF959595), // افتراضي
  });

  @override
  Widget build(BuildContext context) {
    final devices = [
      {
        'name': 'This iPhone',
        'type': 'Active now',
        'icon': Icons.phone_iphone_rounded,
        'active': true,
      },
      {
        'name': 'MacBook Pro',
        'type': 'Last active 2m ago',
        'icon': Icons.laptop_mac_rounded,
        'active': false,
      },
      {
        'name': 'AirPods Pro',
        'type': 'Connected',
        'icon': Icons.headphones_rounded,
        'active': true,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: devices.map((d) {
          final bool isActive = d['active'] as bool;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: [
                // الأيقونة
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isActive
                        ? activeColor.withOpacity(0.15)
                        : (isDark
                              ? const Color(0xFF2A2A2A)
                              : const Color(0xFFF0F0F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    d['icon'] as IconData,
                    color: isActive ? activeColor : inactiveColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d['name'] as String,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          if (isActive) ...[
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: activeColor, // ← استخدام المتغير
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          Text(
                            d['type'] as String,
                            style: TextStyle(color: subTextColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: activeColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Now',
                      style: TextStyle(
                        color: activeColor, // ← استخدام المتغير
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StorageCard extends StatelessWidget {
  final bool isDark;
  final Color textColor, subTextColor;
  final double usedGB, totalGB;

  const _StorageCard({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
    required this.usedGB,
    required this.totalGB,
  });

  @override
  Widget build(BuildContext context) {
    final cacheGB = 0.145;
    final appGB = 0.3;
    final musicGB = usedGB - cacheGB - appGB;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Used Storage',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${usedGB.toStringAsFixed(1)} / ${totalGB.toStringAsFixed(0)} GB',
                style: TextStyle(
                  color: subTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 8,
              child: Row(
                children: [
                  Expanded(
                    flex: (musicGB / totalGB * 100).toInt(),
                    child: Container(color: Appcolor.Primary),
                  ),
                  Expanded(
                    flex: (cacheGB / totalGB * 100).toInt(),
                    child: Container(color: const Color(0xFFFFA07A)),
                  ),
                  Expanded(
                    flex: (appGB / totalGB * 100).toInt(),
                    child: Container(color: const Color(0xFF87CEEB)),
                  ),
                  Expanded(
                    flex: ((totalGB - usedGB) / totalGB * 100).toInt(),
                    child: Container(
                      color: isDark
                          ? const Color(0xFF2A2A2A)
                          : const Color(0xFFF0F0F0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _StorageLegend(
                color: Appcolor.Primary,
                label: 'Music',
                value: '${musicGB.toStringAsFixed(1)} GB',
              ),
              const SizedBox(width: 16),
              _StorageLegend(
                color: const Color(0xFFFFA07A),
                label: 'Cache',
                value: '${cacheGB.toStringAsFixed(1)} GB',
              ),
              const SizedBox(width: 16),
              _StorageLegend(
                color: const Color(0xFF87CEEB),
                label: 'App',
                value: '${appGB.toStringAsFixed(1)} GB',
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.04),
            height: 1,
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B6B).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.delete_outline_rounded,
                      color: Color(0xFFFF6B6B),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Clear Cache',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Free up 145 MB of temporary files',
                          style: TextStyle(color: subTextColor, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B6B).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Clear',
                      style: TextStyle(
                        color: Color(0xFFFF6B6B),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StorageLegend extends StatelessWidget {
  final Color color;
  final String label, value;

  const _StorageLegend({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$label ',
          style: const TextStyle(color: Color(0xFF959595), fontSize: 11),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
