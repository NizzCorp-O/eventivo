import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Data/models/chat_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_bloc.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_event.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/Chat/bloc/chat_state.dart';
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

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadMessages(widget.eventId));
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
      backgroundColor: ColorConstant.MainWhite,
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
          if (state is ChatLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ChatLoaded) {
            return ListView.builder(
              reverse: true, // newest messages at bottom
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final chat = state.messages[index];
                final isMe = chat.senderId == widget.currentUser;

                if (isMe) {
                  return SendMessages(
                    message: chat.message,
                    time: _formatTime(chat.timestamp),
                  );
                } else {
                  return RecievedMessages(
                    userName: chat.senderName,
                    maxLenght: maxLength,
                    message: chat.message,
                    time: _formatTime(chat.timestamp),
                  );
                }
              },
            );
          } else if (state is ChatError) {
            return Center(child: Text(state.error));
          }
          return Container();
        },
      ),
    );
  }
}

///////////////////////////////////////////// Chat UI Widgets /////////////////////////////////////////////
class SendMessages extends StatelessWidget {
  final String message;
  final String time;
  const SendMessages({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(width: 6),
                    Text("You", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 6),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    color: ColorConstant.GradientColor1,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(message, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/user.png"),
          ),
        ],
      ),
    );
  }
}

class RecievedMessages extends StatelessWidget {
  final String userName;
  final int maxLenght;
  final String message;
  final String time;

  const RecievedMessages({
    super.key,
    required this.userName,
    required this.maxLenght,
    required this.message,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    String? profileUrl = FirebaseAuth.instance.currentUser?.photoURL;
    print("profile url : $profileUrl");
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundColor: Colors.grey),
          SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      userName.length <= maxLenght
                          ? userName
                          : "${userName.substring(0, maxLenght)}...",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.blueAccent,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(message, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
