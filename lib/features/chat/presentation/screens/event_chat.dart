import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/presentation/widgets/chat_evetnts.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/chat/presentation/screens/message_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}s ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h ago";
    } else {
      return "${diff.inDays}d ago";
    }
  }

  Future<Map<String, dynamic>?> getLastMessage(String eventId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.data();
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(Myevents());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        title: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
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
      ),
      body: BlocConsumer<EventBloc, EventState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is MyEventLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyEventFetched) {
            if (state.myevents.isEmpty) {
              return Center(
                child: Text(
                  "You have no events. Create or join an event to start chatting!",
                  style: TextStyle(
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }
          }
          if (state is MyEventFetched) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              itemCount: state.myevents.length,
              itemBuilder: (context, index) {
                final event = state.myevents[index];
                return StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('events')
                      .doc(event.id)
                      .collection('chats')
                      .orderBy('timestamp', descending: true)
                      .limit(1)
                      .snapshots(),
                  builder: (context, snapshot) {
                    String recentMessage = "No messages yet";
                    String senderName = "";
                    String time = "";

                    String timeAgoString = "";

                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      final doc = snapshot.data!.docs.first;
                      recentMessage = doc['message'];
                      senderName = doc['senderName'];
                      final ts = doc['timestamp'] as Timestamp;
                      timeAgoString = timeAgo(ts.toDate()); // ← here
                    }

                    return chat_Events(
                      eventId: event.id,
                      URL: event.imageUrls.isNotEmpty ? event.imageUrls[0] : "",
                      time: timeAgoString,
                      title: event.name ?? "",
                      participants: "30",
                      recentmessage: "$senderName : $recentMessage",
                      recentmessagecount: "5", // 🔜 replace with unread count
                      onTap: () {
                        final currentUser =
                            FirebaseAuth.instance.currentUser?.uid;
                        if (currentUser != null &&
                            event.name != null &&
                            event.id != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessageScreen(
                                profileUrl: "",
                                eventTitle: event.name,
                                currentUser: currentUser,
                                eventId: event.id,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Missing event data or user not logged in",
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text("No events currently available"));
        },
      ),
    );
  }
}
