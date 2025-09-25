import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/presentation/widgets/chat_evetnts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/event_Chat_creen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        appBar: AppBar(
          backgroundColor: ColorConstant.MainWhite,
          centerTitle: true,
          title: Center(
            child: Text(
              "Event chat",
              style: TextStyle(
                fontFamily: CustomFontss.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: BlocConsumer<EventBloc, EventState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is EventFetched) {
                  return Column(
                    children: [
                      ...List.generate(
                        state.Events.length,
                        (index) => chat_Events(
                          eventId: state.Events[index].id,
                          URL: state.Events[index].imageUrls[0],
                          time: state.Events[index].starttime,
                          title: state.Events[index].name,
                          participants: "30",
                          recentmessage: "shaeequemohd",
                          recentmessagecount: "5",
                          onTap: () {
                            final currentUser =
                                FirebaseAuth.instance.currentUser?.uid;
                            if (currentUser != null &&
                                state.Events[index].name != null &&
                                state.Events[index].id != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MessageScreen(
                                    profileUrl: "",
                                    eventTitle: state.Events[index].name,
                                    currentUser: currentUser,
                                    eventId: state.Events[index].id,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Missing event data or user not logged in",
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }
                return Center(child: Text("no events currently available"));
              },
            ),
          ),
        ),
      ),
    );
  }
}
