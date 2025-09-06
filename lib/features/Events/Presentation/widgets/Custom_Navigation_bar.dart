import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/chat_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/participant_home_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/profile_screen.dart';

import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> items = [
    {"icon": Icons.calendar_today_outlined, "label": "Events"},
    {"icon": Icons.chat_bubble_outline_outlined, "label": "Chat"},
    {"icon": Icons.person_outlined, "label": "Profile"},
  ];
  Widget getCurrentScreen() {
    switch (selectedIndex) {
      case 1:
        return ChatScreen();
      case 2:
        return ProfileScreen();
      default:
        return ParticipantHomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentScreen(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(thickness: 1, color: ColorConstant.InputBorder, height: 0),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // update tab
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstant.GradientColor2
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item["icon"] as IconData,
                          color: isSelected
                              ? ColorConstant.MainWhite
                              : Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item["label"] as String,
                        style: TextStyle(
                          color: isSelected
                              ? ColorConstant.GradientColor1
                              : Colors.grey,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
