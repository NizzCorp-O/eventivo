
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class My_Events extends StatelessWidget {
  const My_Events({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: ColorConstant.InputBorder.withOpacity(0.3),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/img (4).png",
                      ),
                    ),
                  ),
                  height: 48,
                  width: 48,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Networking Mixer",
                      style: TextStyle(
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Text("Jan 15, 2024"),
                        SizedBox(width: 10),
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: ColorConstant.MainBlack,
                        ),
                        SizedBox(width: 10),
                        Text("09:00 AM"),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "Active",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "32 participants",
                  style: TextStyle(color: ColorConstant.MainBlack),
                ),
                Text(
                  "Manage",
                  style: TextStyle(
                    color: ColorConstant.GradientColor1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}