import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/scanned_tickets_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/particiipant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class My_Events extends StatelessWidget {
  final void Function()? onTicket;
  final String URL;
  final String title;
  final String date;
  final String time;
  final void Function()? onTap;

  const My_Events({
    super.key,
    required this.URL,
    required this.title,
    required this.date,
    required this.time,
    required this.onTap,
    this.onTicket,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      child: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          if (state is EventFetched) {}
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  width: 1,
                  color: ColorConstant.InputBorder,
                ),
                // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)],
                borderRadius: BorderRadius.circular(16),
                color: Colors.transparent,
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(URL),
                          ),
                        ),
                        height: 48,
                        width: 48,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    overflow: TextOverflow.ellipsis,
                                    title,
                                    style: TextStyle(
                                      fontFamily: CustomFontss.fontFamily,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text(date),
                                      SizedBox(width: 5),
                                      CircleAvatar(
                                        radius: 3,
                                        backgroundColor: Colors.green,
                                      ),
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          time,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Wrap VerticalDivider inside SizedBox to give it height
                            SizedBox(
                              height: 80, // or any desired height
                              child: VerticalDivider(
                                color: Colors.grey,
                                width: 10,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),

                      Column(
                        children: [
                          InkWell(
                            onTap: onTicket,

                            child: Container(
                              child: Center(
                                child: Icon(
                                  Icons.qr_code,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 10,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: ColorConstant.GradientColor1,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),

                  Text(
                    "32 participants",
                    style: TextStyle(color: ColorConstant.MainBlack),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
