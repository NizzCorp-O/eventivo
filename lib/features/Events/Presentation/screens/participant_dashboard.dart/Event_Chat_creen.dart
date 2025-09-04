import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class EventChatScreen extends StatelessWidget {
  const EventChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String userName = 'Johnathan Alexander Doe'; // Example long name
    int maxLenght = 15;
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(
                        Icons.emoji_emotions_rounded,
                        color: ColorConstant.Subtittle,
                      ),
                      hintText: "Type a message...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                CircleAvatar(
                  radius: 22,
                  backgroundColor: ColorConstant.GradientColor2,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),

      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          "Tech Conference 2024",
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("assets/images/img (3).png"),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            userName.length <= maxLenght
                                ? userName
                                : userName.substring(0, maxLenght) + '...',
                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,

                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            ' 2:30 PM',
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          color: Colors.blueAccent,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Text(
                          'helooo?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.MainWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align everything to the right
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Message Column (time + "You" + bubble)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Time + You
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "10:35 AM",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "You",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      // Chat Bubble
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          color: ColorConstant.GradientColor2, // Yellow bubble
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        // optional, to avoid super wide bubbles
                        child: Text(
                          'hi, how are you?',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.MainWhite,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                // Profile Picture always at end
                CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
