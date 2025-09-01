import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/botto_naigation.dart';
import 'package:eventivo/features/Events/Presentation/widgets/container_button.dart';
import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/img (2).png",
      "assets/images/div.png",
      "assets/images/bighall.png",
      "assets/images/bighall.png",
    ];
    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      //////// APP BAR  SECTION //////////////
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Center(
          child: Text(
            "Event Details",
            style: TextStyle(
              fontFamily: CustomFontss.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Icon(Icons.favorite_border, size: 28),
          ),
        ],
      ),
      //////////////////////// BODY SECTION ///////////////////
      //////////////////////// BODY SECTION ///////////////////
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 256,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/bighall.png"),
                  ),

                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              SizedBox(height: 24),
              Text(
                softWrap: true,
                overflow: TextOverflow.visible,

                "Tech Conference 2024",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 12),
              ///// DATE AND PLACE SECTION ///////
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.withOpacity(.1),
                        ),
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorConstant.GradientColor1,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 1,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              "December 15, 2025",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                                fontSize: 16,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Text(
                              "9:00 AM - 6:00 PM",
                              style: TextStyle(
                                color: ColorConstant.Subtittle,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.amber.withOpacity(.1),
                        ),
                        padding: EdgeInsets.all(9),
                        child: Icon(
                          Icons.location_on_rounded,
                          color: ColorConstant.GradientColor1,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // softWrap: true,
                              // overflow: TextOverflow.ellipsis,
                              "Le Meridian Convention Center",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,

                                fontSize: 16,
                                color: Color(0xFF111827),
                              ),
                            ),
                            Text(
                              "3001 Expo Blvd, Santa Clara, CA",
                              style: TextStyle(
                                color: ColorConstant.Subtittle,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              ////// MEDIA SECTION //////
              SizedBox(height: 24),
              Text(
                "Media Gellery",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    images.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 96,
                        width: 96,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(images[index]),
                          ),

                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Event Programs",
                style: TextStyle(
                  fontFamily: CustomFontss.fontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Column(
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xffF9FAFB),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Opening keynotes",
                                  style: TextStyle(
                                    fontFamily: CustomFontss.fontFamily,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),

                              Text(
                                "9:00 AM",
                                style: TextStyle(
                                  color: ColorConstant.GradientColor1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Future of Technology & Innovation",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorConstant.Subtittle,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Main Auditorium • 60 minutes",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF6B7280),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 17),

              ////////// JION BUTTON SECTION ///////////
              ///////////// JION BUTTON SECTION ///////////
              ContainerButton(title: "Join Event", onPressed: () {}),
              SizedBox(height: 12),
              ////////////. chat section //////////
              InkWell(
                onTap: () {},
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: BoxBorder.all(
                      width: 1,
                      color: ColorConstant.GradientColor1,
                    ),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline_outlined,
                          color: ColorConstant.GradientColor1,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Chat with Coordinators",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.GradientColor1,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
