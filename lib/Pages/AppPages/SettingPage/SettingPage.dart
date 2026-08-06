import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify/Common/widgets/AppBar.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
  double _storageUsed = 2.4; // GB

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Appcolor.DarkBg : Appcolor.LightBg;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white60 : Colors.black45;
    final cardBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: BasicAppBar(
        hidIcons: false,
        hidarrow: true,
        Title: SvgPicture.asset('Assest/Vectors/Logo.svg', height: 33),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              // ═══════════════════════════════════════
              // 1. PROFILE HEADER (Premium Badge)
              // ═══════════════════════════════════════
              _ProfileHeader(
                textColor: textColor,
                subTextColor: subTextColor,
                cardBg: cardBg,
                isDark: isDark,
              ),

              // ═══════════════════════════════════════
              // 2. LISTENING STATS (Spotify Wrapped Mini)
              // ═══════════════════════════════════════
              const SizedBox(height: 24),

              // ═══════════════════════════════════════
              // 3. STORAGE VISUALIZER (Progress Bars)
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Devices', color: textColor),
              const SizedBox(height: 12),
              _DevicesCard(
                isDark: isDark,
                textColor: textColor,
                subTextColor: subTextColor,
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════
              // 4. CONNECTED DEVICES (Live)
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Storge', color: textColor),
              const SizedBox(height: 12),

              _StorageCard(
                isDark: isDark,
                textColor: textColor,
                subTextColor: subTextColor,
                usedGB: _storageUsed,
                totalGB: 16.0,
              ),
              const SizedBox(height: 24),
              // ═══════════════════════════════════════
              // 5. PLAYBACK SETTINGS (Crossfade Slider)
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Playback', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SettingsTile(
                    icon: Icons.high_quality_outlined,
                    iconColor: const Color(0xFFFFA07A),
                    iconBg: const Color(0xFFFFA07A).withOpacity(0.15),
                    title: 'Streaming Quality',
                    subtitle: 'Very High (320 kbps)',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    trailing: Icon(
                      Icons.chevron_right_rounded,
                      color: subTextColor,
                      size: 20,
                    ),
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.shuffle_rounded,
                    iconColor: const Color(0xFFDDA0DD),
                    iconBg: const Color(0xFFDDA0DD).withOpacity(0.15),
                    title: 'Smart Shuffle',
                    subtitle: 'AI-powered song recommendations',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _smartShuffle,
                    onChanged: (v) => setState(() => _smartShuffle = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.merge_type_rounded,
                    iconColor: const Color(0xFFFFE66D),
                    iconBg: const Color(0xFFFFE66D).withOpacity(0.15),
                    title: 'Crossfade',
                    subtitle: 'Smooth transition between songs',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _crossfade,
                    onChanged: (v) => setState(() => _crossfade = v),
                  ),
                  // Crossfade Slider (يظهر فقط إذا مفعل)
                  if (_crossfade) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(72, 0, 20, 16),
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
                              onChanged: (v) =>
                                  setState(() => _crossfadeSeconds = v),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.music_note_outlined,
                    iconColor: const Color(0xFF4ECDC4),
                    iconBg: const Color(0xFF4ECDC4).withOpacity(0.15),
                    title: 'Gapless Playback',
                    subtitle: 'No silence between tracks',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _gaplessPlayback,
                    onChanged: (v) => setState(() => _gaplessPlayback = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.explicit_outlined,
                    iconColor: const Color(0xFFFF6B6B),
                    iconBg: const Color(0xFFFF6B6B).withOpacity(0.15),
                    title: 'Allow Explicit Content',
                    subtitle: 'Show songs with explicit lyrics',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _explicitContent,
                    onChanged: (v) => setState(() => _explicitContent = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.wifi_tethering_outlined,
                    iconColor: const Color(0xFF87CEEB),
                    iconBg: const Color(0xFF87CEEB).withOpacity(0.15),
                    title: 'Data Saver',
                    subtitle: 'Reduce data usage while streaming',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _dataSaver,
                    onChanged: (v) => setState(() => _dataSaver = v),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════
              // 6. CANVAS & CAR MODE (Mood Features)
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Experience', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SwitchTile(
                    icon: Icons.auto_awesome_rounded,
                    iconColor: const Color(0xFFFF6B6B),
                    iconBg: const Color(0xFFFF6B6B).withOpacity(0.15),
                    title: 'Canvas',
                    subtitle: 'Short looping visuals on Now Playing',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _canvasEnabled,
                    onChanged: (v) => setState(() => _canvasEnabled = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.directions_car_rounded,
                    iconColor: const Color(0xFF667EEA),
                    iconBg: const Color(0xFF667EEA).withOpacity(0.15),
                    title: 'Car Mode',
                    subtitle: 'Simplified UI while driving',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _carMode,
                    onChanged: (v) => setState(() => _carMode = v),
                  ),
                  _Divider(isDark: isDark),
                  _SettingsTile(
                    icon: Icons.nights_stay_rounded,
                    iconColor: const Color(0xFFFFA07A),
                    iconBg: const Color(0xFFFFA07A).withOpacity(0.15),
                    title: 'Sleep Timer',
                    subtitle: 'Stop playback after a set time',
                    textColor: textColor,
                    subTextColor: subTextColor,
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

              // ═══════════════════════════════════════
              // 7. NOTIFICATIONS
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Notifications', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SwitchTile(
                    icon: Icons.notifications_none_rounded,
                    iconColor: Appcolor.Primary,
                    iconBg: Appcolor.Primary.withOpacity(0.15),
                    title: 'Push Notifications',
                    subtitle: 'New releases, playlists & more',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _pushNotifications,
                    onChanged: (v) => setState(() => _pushNotifications = v),
                  ),
                  _Divider(isDark: isDark),
                  _SwitchTile(
                    icon: Icons.email_outlined,
                    iconColor: const Color(0xFF87CEEB),
                    iconBg: const Color(0xFF87CEEB).withOpacity(0.15),
                    title: 'Email Updates',
                    subtitle: 'Weekly digest & promotions',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _emailNotifications,
                    onChanged: (v) => setState(() => _emailNotifications = v),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ═══════════════════════════════════════
              // 8. APPEARANCE
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Appearance', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SwitchTile(
                    icon: Icons.dark_mode_outlined,
                    iconColor: const Color(0xFF667EEA),
                    iconBg: const Color(0xFF667EEA).withOpacity(0.15),
                    title: 'Dark Mode',
                    subtitle: 'Toggle between light & dark theme',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    value: _darkMode,
                    onChanged: (v) => setState(() => _darkMode = v),
                  ),
                  _Divider(isDark: isDark),
                  _SettingsTile(
                    icon: Icons.language_rounded,
                    iconColor: const Color(0xFFFFA07A),
                    iconBg: const Color(0xFFFFA07A).withOpacity(0.15),
                    title: 'Language',
                    subtitle: 'English (US)',
                    textColor: textColor,
                    subTextColor: subTextColor,
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

              // ═══════════════════════════════════════
              // 9. SOCIAL & SHARE (QR Code)
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Social', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SettingsTile(
                    icon: Icons.qr_code_rounded,
                    iconColor: Appcolor.Primary,
                    iconBg: Appcolor.Primary.withOpacity(0.15),
                    title: 'Share Profile',
                    subtitle: 'Show QR code for your profile',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),
                  _SettingsTile(
                    icon: Icons.group_add_outlined,
                    iconColor: const Color(0xFF4ECDC4),
                    iconBg: const Color(0xFF4ECDC4).withOpacity(0.15),
                    title: 'Listening Together',
                    subtitle: 'Start a group listening session',
                    textColor: textColor,
                    subTextColor: subTextColor,
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

              // ═══════════════════════════════════════
              // 10. SUPPORT
              // ═══════════════════════════════════════
              _SectionTitle(title: 'Support', color: textColor),
              const SizedBox(height: 12),
              _SettingsCard(
                isDark: isDark,
                children: [
                  _SettingsTile(
                    icon: Icons.help_outline_rounded,
                    iconColor: const Color(0xFF87CEEB),
                    iconBg: const Color(0xFF87CEEB).withOpacity(0.15),
                    title: 'Help Center',
                    subtitle: 'FAQs, troubleshooting guides',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),
                  _SettingsTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    iconColor: Appcolor.Primary,
                    iconBg: Appcolor.Primary.withOpacity(0.15),
                    title: 'Contact Us',
                    subtitle: 'Get in touch with support',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    onTap: () {},
                  ),
                  _Divider(isDark: isDark),
                  _SettingsTile(
                    icon: Icons.info_outline_rounded,
                    iconColor: const Color(0xFFFFE66D),
                    iconBg: const Color(0xFFFFE66D).withOpacity(0.15),
                    title: 'About',
                    subtitle: 'Version 2.4.1 • Terms & Privacy Policy',
                    textColor: textColor,
                    subTextColor: subTextColor,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // ═══════════════════════════════════════
              // 11. LOGOUT
              // ═══════════════════════════════════════
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B6B).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFFF6B6B).withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFFF6B6B),
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xFFFF6B6B),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
      ),
    );
  }
}

// ═══════════════════════════════════════════════════
// WIDGETS
// ═══════════════════════════════════════════════════

class _ProfileHeader extends StatelessWidget {
  final Color textColor;
  final Color subTextColor;
  final Color cardBg;
  final bool isDark;

  const _ProfileHeader({
    required this.textColor,
    required this.subTextColor,
    required this.cardBg,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // Avatar
          Stack(
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,

                  image: const DecorationImage(
                    image: AssetImage('Assest/Images/Avtar.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),

          // Info
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

          // Edit
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

// ─── 2. LISTENING STATS GRID ───

// ─── 3. STORAGE VISUALIZER ───
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
    final percent = usedGB / totalGB;
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
          // Progress Bar
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
          // Legend
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

// ─── 4. CONNECTED DEVICES ───
class _DevicesCard extends StatelessWidget {
  final bool isDark;
  final Color textColor, subTextColor;

  const _DevicesCard({
    required this.isDark,
    required this.textColor,
    required this.subTextColor,
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
      padding: const EdgeInsets.all(16),
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
        children: devices.map((d) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: (d['active'] as bool)
                        ? Appcolor.Primary.withOpacity(0.15)
                        : (isDark
                              ? const Color(0xFF2A2A2A)
                              : const Color(0xFFF0F0F0)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    d['icon'] as IconData,
                    color: (d['active'] as bool)
                        ? Appcolor.Primary
                        : subTextColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
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
                          if (d['active'] as bool) ...[
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Appcolor.Primary,
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
                if (d['active'] as bool)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Appcolor.Primary.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Now',
                      style: TextStyle(
                        color: Appcolor.Primary,
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

// ─── BASE WIDGETS ───
class _SectionTitle extends StatelessWidget {
  final String title;
  final Color color;

  const _SectionTitle({required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.3,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;

  const _SettingsCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String title, subtitle;
  final Color textColor, subTextColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.subTextColor,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
      ),
      trailing:
          trailing ??
          Icon(Icons.chevron_right_rounded, color: subTextColor, size: 20),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor, iconBg;
  final String title, subtitle;
  final Color textColor, subTextColor;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.textColor,
    required this.subTextColor,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Text(
          subtitle,
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
      ),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: Appcolor.Primary,
        activeTrackColor: Appcolor.Primary.withOpacity(0.3),
        inactiveThumbColor: Colors.grey.shade400,
        inactiveTrackColor: Colors.grey.shade700.withOpacity(0.3),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;

  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: isDark
          ? Colors.white.withOpacity(0.06)
          : Colors.black.withOpacity(0.04),
      height: 1,
      indent: 72,
      endIndent: 16,
    );
  }
}
