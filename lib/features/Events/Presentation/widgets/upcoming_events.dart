import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class UpcomingEvent extends StatelessWidget {
  final String eventId;
  final String title;
  final String imageUlr;
  final String date;
  final String starttime;
  const UpcomingEvent({
    super.key,
    required this.title,
    required this.imageUlr,
    required this.date,
    required this.starttime,
    required this.eventId,
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
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUlr),
                ),
              ),
              height: 48,
              width: 48,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    // softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: CustomFontss.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        date,
                        style: TextStyle(color: ColorConstant.PrimaryBlue),
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(radius: 3, backgroundColor: Colors.green),
                      SizedBox(width: 10),
                      Text(
                        starttime,
                        style: TextStyle(color: ColorConstant.GradientColor2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
