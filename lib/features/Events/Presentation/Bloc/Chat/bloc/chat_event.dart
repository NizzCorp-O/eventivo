import 'package:eventivo/features/Events/Data/models/chat_models.dart';

abstract class ChatEvent {}

class LoadMessages extends ChatEvent {
  final String eventId;
  LoadMessages(this.eventId);
}

class SendMessageEvent extends ChatEvent {
  final String eventId;
  final ChatModel message;
  SendMessageEvent({required this.eventId, required this.message});
}
class DeleteMessage extends ChatEvent{
   final String eventId;
  final String messageId;

  DeleteMessage({required this.eventId, required this.messageId});
  
}
