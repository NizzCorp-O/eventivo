import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/chat_models.dart';

class ChatService {
  Future<void> sendMessage(ChatModel message, String eventId) async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("chats")
        .add(message.toJson());
  }

  Stream<List<ChatModel>> getMessages(String eventId) {
    return FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("chats")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModel.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> deleteMessage(String eventId, String messageId) async {
    await FirebaseFirestore.instance
        .collection("events")
        .doc(eventId)
        .collection("chats")
        .doc(messageId)
        .delete();
  }
}
