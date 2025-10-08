import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/constants/sizedBox/App_spaces.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String URL;
  final String Eventname;
  final String date;
  final String time;
  final String venue;

  final void Function()? onTap;
  const EventCard({
    super.key,
    this.onTap,
    required this.URL,
    required this.Eventname,
    required this.date,
    required this.time,
    required this.venue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 5, bottom: 5, right: 18),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSpaces.height7,

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17,
                      top: 17,
                      right: 17,
                      bottom: 37,
                    ),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(URL),
                        ),

                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.visible,

                          Eventname,
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: ColorConstant.GradientColor1,
                              size: 20,
                            ),
                            SizedBox(width: 6),
                            Text(date),
                            SizedBox(width: 10),
                            Icon(
                              Icons.watch_later_outlined,
                              color: ColorConstant.GradientColor1,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            /////////  Time Section //////////////////
                            Flexible(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                time.toString(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_sharp,
                              color: ColorConstant.GradientColor2,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                // allow wrapping
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                venue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ],
          ),

          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: BoxBorder.all(width: 1, color: ColorConstant.InputBorder),
          ),
        ),
      ),
    );
  }
}
