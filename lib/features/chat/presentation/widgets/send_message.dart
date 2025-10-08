import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:flutter/material.dart';

class SendMessages extends StatelessWidget {
  final void Function()? onTap;
  final String profilepic;
  final String message;
  final String time;
  const SendMessages({
    super.key,
    required this.message,
    required this.time,
    required this.profilepic,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                    SizedBox(width: 6),
                    Text(
                      "You",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                InkWell(
                  onTap: onTap,

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      color: ColorConstant.GradientColor1,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Text(message, style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: ColorConstant.GradientColor1,
            radius: 20,
            backgroundImage: (profilepic.isNotEmpty)
                ? NetworkImage(profilepic)
                : null, // only load when image exists
            child: profilepic.isEmpty
                ? const Icon(Icons.person, color: Colors.black) // fallback
                : null,
          ),
        ],
      ),
    );
  }
}
