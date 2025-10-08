import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class chat_Events extends StatefulWidget {
  final String URL;
  final String title;
  final String time;
  final String participants;
  final String recentmessage;
  final String recentmessagecount;
  final String eventId;
  final void Function()? onTap;

  const chat_Events({
    super.key,
    required this.URL,
    required this.title,
    required this.time,
    required this.participants,
    required this.recentmessage,
    required this.recentmessagecount,
    required this.eventId,
    this.onTap,
  });

  @override
  State<chat_Events> createState() => _chat_EventsState();
}

class _chat_EventsState extends State<chat_Events> {
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.eventId));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          InkWell(
            onTap: widget.onTap,

            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.URL),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                maxLines: 1,

                                overflow: TextOverflow.ellipsis,
                                widget.title,
                                style: TextStyle(
                                  fontFamily: CustomFontss.fontFamily,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorConstant.MainBlack,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${widget.time}",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: ColorConstant.GradientColor1,
                              ),
                            ),
                          ],
                        ),

                        Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          widget.recentmessage,
                          style: TextStyle(color: ColorConstant.PrimaryBlue),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "${widget.participants} Participants",
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
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
