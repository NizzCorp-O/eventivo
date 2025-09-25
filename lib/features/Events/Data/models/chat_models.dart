import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String senderId;
  String senderName; // display name of sender
  String message;
  Timestamp timestamp;
  String senderImageUrl;

  ChatModel({
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.timestamp,
    required this.senderImageUrl,
  });

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'senderName': senderName,
        'message': message,
        'timestamp': timestamp,
        'senderImageUrl': senderImageUrl,
      };

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        senderId: json['senderId'],
        senderName: json['senderName'],
        message: json['message'],
        timestamp: json['timestamp'],
        senderImageUrl: json['senderImageUrl'],
      );
}
