
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          "Event chat",
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            children: [...List.generate(10, (index) => chat_Events())],
          ),
        ),
      ),
    );
  }
}

class chat_Events extends StatelessWidget {
  const chat_Events({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/div.png"),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,

                      backgroundColor: ColorConstant.GradientColor2,
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontFamily: CustomFontss.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: ColorConstant.MainWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            maxLines: 1,

                            overflow: TextOverflow.ellipsis,
                            "Tech conference  dasdfdasfjasj",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: ColorConstant.MainBlack,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text("2m ago"),
                      ],
                    ),

                    Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "Event Coordinator: Welcome everyone! The conference is starting...",
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        CircleAvatar(radius: 4, backgroundColor: Colors.green),
                        SizedBox(width: 8),
                        Text(
                          "24 Participants",
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
