import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final String URL;
  final void Function()? onTap;
  const EventCard({super.key, this.onTap, required this.URL});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, bottom: 4, top: 18, right: 24),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),

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
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(URL),
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

                          "Happy new year",
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            fontWeight: FontWeight.w500,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [Text("Dec14,"), Text("2025")],
                            ),
                            SizedBox(width: 20),
                            Row(
                              children: [
                                Icon(
                                  Icons.watch_later_outlined,
                                  color: ColorConstant.GradientColor1,
                                  size: 20,
                                ),
                                SizedBox(width: 6),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text("09.00"), Text("Am")],
                                ),
                              ],
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
                            Expanded(
                              child: Text(
                                // allow wrapping
                                overflow: TextOverflow.visible,
                                maxLines: 1,
                                "Crown plaza Kochi",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 17),
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
