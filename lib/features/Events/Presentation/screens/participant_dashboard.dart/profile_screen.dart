import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/widgets/buildDot.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        appBar: AppBar(
          backgroundColor: ColorConstant.MainWhite,
          centerTitle: true,
          title: Text(
            "Profile",
            style: TextStyle(
              fontFamily: CustomFontss.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height: 32),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: AssetImage(
                              "assets/images/user.png",
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              overlayColor: WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              onTap: () {
                                ///////// handle the fuction in image /////
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: ColorConstant.GradientColor1,
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      Text(
                        "Sarah Johnson",
                        style: TextStyle(
                          fontFamily: CustomFontss.fontFamily,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 6),
                      Text(
                        "sarah.johnson@email.com",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.Subtittle,
                        ),
                      ),

                      SizedBox(height: 30),

                      SizedBox(
                        width: 180,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.GradientColor1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  "Upcoming Events",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 18),
                ///////////// UPCOMING EVENTS /////////////
                //////////////// UPCOMING EVENTS /////////////
                ...List.generate(2, (index) => UpcomingEvent()),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "My Events",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 9,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: ColorConstant.MainWhite),
                          SizedBox(width: 5),
                          Text(
                            "Create Event",
                            style: TextStyle(color: ColorConstant.MainWhite),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF1A237E),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Padding(
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
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////// UpcomingEventContainer ////////////////////////
///////////////////////////////////////// UpcomingEventContainer ////////////////////////
class UpcomingEvent extends StatelessWidget {
  const UpcomingEvent({super.key});

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
                  image: AssetImage("assets/images/hall.png"),
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
                    "Tech conference 2024 ",
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
            ),
            SizedBox(width: 8),
            CircleAvatar(
              radius: 4,
              backgroundColor: ColorConstant.GradientColor2,
            ),
          ],
        ),
      ),
    );
  }
}
