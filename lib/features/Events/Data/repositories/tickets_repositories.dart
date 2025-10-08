import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsRepositories {
  Future<Map<String, dynamic>?> getTicket(String eventId, String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("tickets")
        .doc(userId)
        .get();

    if (doc.exists && doc.data() != null) {
      return doc.data()!; // Direct map
    }

    return null;
    // Ticket not found
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
      "eventId":eventId,
      "paymentId": paymentId,
      "attendees": attendees,
      "eventTitle": eventTitle,
      "qrUrl": qrUrl, // <-- store QR URL
      "createdAt": FieldValue.serverTimestamp(),
    });
  }
}
