import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:flutter/material.dart';

class RecievedMessages extends StatelessWidget {
  final String profileImage;
  final String userName;
  final int maxLenght;
  final String message;
  final String time;

  const RecievedMessages({
    super.key,
    required this.userName,
    required this.maxLenght,
    required this.message,
    required this.time,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    // String? profileUrl = FirebaseAuth.instance.currentUser?.photoURL;
    // print("profile url : $profileUrl");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            backgroundImage: (profileImage.isNotEmpty)
                ? NetworkImage(profileImage)
                : null, // only load when image exists
            child: profileImage.isEmpty
                ? const Icon(Icons.person, color: Colors.black) // fallback
                : null,
            radius: 20,
          ),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName.length <= maxLenght
                          ? userName
                          : "${userName.substring(0, maxLenght)}...",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(width: 5),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 1),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(message, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
