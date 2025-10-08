import 'package:eventivo/features/Events/Data/models/chat_models.dart';
import 'package:eventivo/features/chat/data/repositories/chat_repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatService chatService;

  ChatBloc(this.chatService) : super(ChatInitial()) {
    // Load messages (real-time stream from Firestore)
    on<LoadMessages>((event, emit) async {
      emit(ChatLoading());
      try {
        await emit.forEach<List<ChatModel>>(
          chatService.getMessages(
            event.eventId,
          ), // returns Stream<List<ChatModel>>
          onData: (messages) => ChatLoaded(messages),
          onError: (error, stackTrace) => ChatError(error.toString()),
        );
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });

    // Send message
    on<SendMessageEvent>((event, emit) async {
      try {
        await chatService.sendMessage(event.message, event.eventId);
      } catch (e) {
        emit(ChatError("Failed to send message: $e"));
      }
    });
    on<DeleteMessage>((event, emit) async {
      try {
        await chatService.deleteMessage(event.eventId, event.messageId);
        emit(MessageDelete());
        add(LoadMessages(event.eventId)); // refresh messages
      } catch (e) {
        emit(ChatError(e.toString()));
      }
    });
  }
}
