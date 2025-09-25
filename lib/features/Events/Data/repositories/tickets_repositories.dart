import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsRepositories {
  Future<bool> hasTicket(String eventId, String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("tickets")
        .doc(userId)
        .get();

    return doc.exists;
  }

  Future<Map<String, dynamic>?> getTicket(String eventId, String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("tickets")
        .doc(userId)
        .get();

    return doc.exists ? doc.data() : null;
  }

  Future<void> saveTicket(
    String eventId,
    String userId,
    String paymentId,
    num attendees,
    String eventTitle,
    String qrUrl, // <-- add QR URL
  ) async {
    final doc = await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("tickets")
        .doc(userId);
    await doc.set({
      "paymentId": paymentId,
      "attendees": attendees,
      "eventTitle": eventTitle,
      "qrUrl": qrUrl, // <-- store QR URL
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}
