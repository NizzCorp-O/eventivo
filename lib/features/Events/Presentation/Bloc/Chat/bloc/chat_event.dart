import 'package:eventivo/features/Events/Data/models/chat_models.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String eventId;
  LoadMessages(this.eventId);
}

class SendMessageEvent extends ChatEvent {
  final String eventId;
  final ChatModels message;
  SendMessageEvent({required this.eventId, required this.message});
}
