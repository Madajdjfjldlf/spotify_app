import 'package:flutter/material.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/ThemApp.dart/App_Color.dart';
import 'SettingData.dart';

class CustomSettingGroup extends StatelessWidget {
  const CustomSettingGroup({super.key, required this.items});
  final List<Settingdata> items;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Container(
      width: double.infinity,
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView.separated(
          separatorBuilder: (_, __) => Divider(
            height: 1,
            thickness: 0.8,
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : Colors.black.withOpacity(0.04),
            indent: 72,
            endIndent: 16,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: item.isSwitch ? null : item.onTap,
                splashColor: isDark
                    ? Colors.white.withOpacity(0.05)
                    : Colors.black.withOpacity(0.03),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isDark
                              ? const Color(0xff2C2C2C)
                              : const Color(0xffE6E6E6),
                        ),
                        child: Icon(
                          item.icon,
                          color: context.isDarkMode
                              ? const Color(0xff959595)
                              : const Color(0xff555555),
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white : Colors.black87,
                                letterSpacing: -0.2,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500,
                                  color: isDark
                                      ? const Color(0xFF959595)
                                      : const Color(0xFF777777),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (item.isSwitch && item.switchValue != null)
                        Switch.adaptive(
                          value: item.switchValue!,
                          onChanged: item.onSwitchChanged,
                          activeColor: Appcolor.Primary,
                          activeTrackColor: Appcolor.Primary.withOpacity(0.3),
                          inactiveThumbColor: isDark
                              ? const Color(0xFF666666)
                              : Colors.grey.shade400,
                          inactiveTrackColor: isDark
                              ? const Color(0xFF3A3A3A)
                              : Colors.grey.shade300,
                        )
                      else if (item.trailing != null)
                        item.trailing!
                      else
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: isDark
                              ? const Color(0xFF959595)
                              : const Color(0xFF999999),
                          size: 14,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
