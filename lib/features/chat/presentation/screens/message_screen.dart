import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/chat_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_event.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_state.dart';
import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/chat/presentation/widgets/recieve_message.dart';
import 'package:eventivo/features/chat/presentation/widgets/send_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  final String eventId;
  final String eventTitle;
  final String currentUser;
  final String profileUrl;

  const MessageScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.currentUser,
    required this.profileUrl,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

Future<String?> getUserProfileImage(String userId) async {
  final doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .get();

  if (doc.exists && doc.data()!.containsKey("profileImage")) {
    return doc.data()!["profileImage"];
  }
  return null; // default image
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.eventId));
    context.read<AuthBlocBloc>().add(LoadProfileImageEvent());
  }

  String _formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();

    int hour = dateTime.hour;
    int minute = dateTime.minute;

    String amPm = hour >= 12 ? "PM" : "AM";
    hour = hour % 12;
    if (hour == 0) hour = 12; // 12 AM or PM instead of 0

    String minuteStr = minute.toString().padLeft(2, '0');

    return "$hour:$minuteStr $amPm";
  }

  @override
  Widget build(BuildContext context) {
    int maxLength = 15;

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(
                        Icons.emoji_emotions_rounded,
                        color: ColorConstant.Subtittle,
                      ),
                      hintText: "Type your message...",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: ColorConstant.InputBorder,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      context.read<ChatBloc>().add(
                        SendMessageEvent(
                          eventId: widget.eventId,
                          message: ChatModel(
                            senderImageUrl: widget.profileUrl,
                            senderId: widget.currentUser,
                            message: messageController.text,
                            senderName:
                                FirebaseAuth
                                    .instance
                                    .currentUser
                                    ?.displayName ??
                                "anonymous",

                            timestamp: Timestamp.now(),
                          ),
                        ),
                      );
                      messageController.clear();
                    }
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: ColorConstant.GradientColor1,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          widget.eventTitle,
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoaded) {
            return ListView.builder(
              reverse: true, // newest messages at bottom
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final chat = state.messages[index];
                final isMe = chat.senderId == widget.currentUser;

                if (isMe) {
                  return FutureBuilder<String?>(
                    future: getUserProfileImage(widget.currentUser), // senderId
                    builder: (context, snapshot) {
                      final profileImage = snapshot.data;

                      return SendMessages(
                        profilepic:
                            (profileImage != null && profileImage.isNotEmpty)
                            ? profileImage // valid URL
                            : "", // empty → will show icon in CircleAvatar
                        message: chat.message,
                        time: _formatTime(chat.timestamp),
                      );
                    },
                  );
                } else {
                  return FutureBuilder<String?>(
                    initialData: "",
                    future: getUserProfileImage(chat.senderId),
                    builder: (context, snapshot) {
                      final profileImage =
                          (snapshot.data != null && snapshot.data!.isNotEmpty)
                          ? snapshot.data!
                          : ""; // empty → means no image

                      return RecievedMessages(
                        profileImage: profileImage,
                        userName: chat.senderName,
                        maxLenght: maxLength,
                        message: chat.message,
                        time: _formatTime(chat.timestamp),
                      );
                    },
                  );
                }
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.error));
          }
          return Text("");
        },
      ),
    );
  }
}

