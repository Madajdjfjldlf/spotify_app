import 'package:flutter/material.dart';
import 'package:spotify/Common/Helpers/is_dark.dart';
import 'package:spotify/Pages/AppPages/SettingPage/SettingData.dart';

class CustomSettingGroup extends StatelessWidget {
  const CustomSettingGroup({super.key, required this.items});
  final List<Settingdata> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // أضف لون الخلفية هنا حسب الوضع (داكن أو فاتح)
        color: context.isDarkMode ? const Color(0xff121212) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView.separated(
        separatorBuilder: (_, __) => Divider(
          height: 1,
          thickness: 0.8,
          color: context.isDarkMode
              ? const Color(0xff2C2C2C)
              : const Color(0xffE6E6E6),
          indent: 60,
          endIndent: 16,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return InkWell(
            onTap: item.onTap,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: context.isDarkMode
                          ? const Color(0xff2C2C2C)
                          : const Color(0xffE6E6E6),
                    ),
                    child: Icon(
                      item.icon,
                      color: context.isDarkMode
                          ? const Color(0xff959595)
                          : const Color(0xff555555),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: context.isDarkMode
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        if (item.Subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            item.Subtitle!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: context.isDarkMode
                                  ? const Color(0xff959595)
                                  : const Color(0xff777777),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: context.isDarkMode
                        ? const Color(0xff959595)
                        : const Color(0xff555555),
                    size: 13,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
