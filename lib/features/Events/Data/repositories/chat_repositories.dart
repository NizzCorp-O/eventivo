import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/chat_models.dart';

class ChatRepository {
  Stream<List<ChatModels>> getMessages(String eventId) {
    return FirebaseFirestore.instance
        .collection("chats")
        .doc(eventId)
        .collection("messages")
        .orderBy("time", descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatModels.fromJson(doc.data()))
              .toList(),
        );
  }

  Future<void> sendMessage(ChatModels message, String eventId) async {
    await FirebaseFirestore.instance
        .collection("chats")
        .doc(eventId)
        .collection("messages")
        .add(message.toJson());
  }
}
