import 'package:cloud_firestore/cloud_firestore.dart';

class TicketModel {
  final String paymentId;
  final num attendees;
  final String eventTitle;
  final String qrUrl;
  final DateTime createdAt;

  TicketModel({
    required this.paymentId,
    required this.attendees,
    required this.eventTitle,
    required this.qrUrl,
    required this.createdAt,
  });

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      paymentId: map['paymentId'] ?? '',
      attendees: map['attendees'] ?? 0,
      eventTitle: map['eventTitle'] ?? '',
      qrUrl: map['qrUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "paymentId": paymentId,
      "attendees": attendees,
      "eventTitle": eventTitle,
      "qrUrl": qrUrl,
      "createdAt": FieldValue.serverTimestamp(),
    };
  }
}
