import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/Event_detail_Screen.dart';
import 'package:eventivo/features/Events/Presentation/widgets/event_card.dart';
import 'package:eventivo/features/Events/Presentation/widgets/event_widgets/filtered_events.dart';
import 'package:flutter/material.dart';

class ParticipantHomeScreen extends StatefulWidget {
  const ParticipantHomeScreen({super.key});

  @override
  State<ParticipantHomeScreen> createState() => _ParticipantHomeScreenState();
}

class _ParticipantHomeScreenState extends State<ParticipantHomeScreen> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    List<String> EventsUrl = [
      "assets/images/hall.png",
      "assets/images/img (3).png",
      "assets/images/img (4).png",
      "assets/images/img (2).png",
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        body: CustomScrollView(
          slivers: [
            ///////. APP BAR /////////
            /// ///////. APP BAR /////////
            //////////. APP BAR /////////
            SliverAppBar(
              backgroundColor: ColorConstant.MainWhite,
              expandedHeight: 100,
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24, top: 24),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              "Events",
                              style: TextStyle(
                                fontFamily: CustomFontss.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: ColorConstant.MainBlack,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Discover amazing events near you",
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: ColorConstant.MainBlack,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 24,
                            top: 6,
                            bottom: 6,
                          ),
                          child: Container(
                            height: 44,
                            width: 44,

                            child: Center(
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: ColorConstant.MainWhite,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                colors: [
                                  ColorConstant.GradientColor1,
                                  ColorConstant.GradientColor2,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 24, right: 24),
                child: Column(
                  children: [
                    SizedBox(height: 24),
                    TextField(
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorConstant.InputText,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ColorConstant.InputBorder,
                          ),
                        ),
                        hintText: 'Search Events..',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorConstant.InputBorder,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: ColorConstant.InputText,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    /////// EVENT FILTERING SECTION ///////
                    //////// EVENT FILTERING SECTION //////
                    /////////// EVENT FILTERING SECTION ////
                    Row(
                      children: [
                        FilteredContainer(
                          onTap: () {
                            setState(() {
                              selectedindex = 0;
                            });
                          },
                          tittle: "Today",
                          selectedindex: selectedindex == 0,
                          icons: Icons.today_outlined,
                        ),
                        SizedBox(width: 12),
                        FilteredContainer(
                          onTap: () {
                            setState(() {
                              selectedindex = 1;
                            });
                          },
                          icons: Icons.calendar_today_rounded,
                          tittle: "This Week",
                          selectedindex: selectedindex == 1,
                        ),
                        SizedBox(width: 12),
                        FilteredContainer(
                          onTap: () {
                            setState(() {
                              selectedindex = 2;
                            });
                          },
                          tittle: "Filter",
                          selectedindex: selectedindex == 2,
                          icons: Icons.filter_list_rounded,
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            ////// EVENT CARD SECTION ////////
            ///////// EVENT CARD SECTION //////
            ///////// EVENT CARD SECTION ////////
            SliverList.separated(
              itemCount: EventsUrl.length,
              itemBuilder: (context, index) => EventCard(
                URL: EventsUrl[index],

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(),
                    ),
                  );
                },
              ),
              separatorBuilder: (context, index) => SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
