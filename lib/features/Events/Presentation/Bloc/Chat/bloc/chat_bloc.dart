import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventivo/features/Events/Data/repositories/chat_repositories.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;
  StreamSubscription? _subscription;

  ChatBloc(this.chatRepository) : super(ChatInitial()) {
    on<LoadMessages>(_onLoadMessages);
    on<SendMessageEvent>(onSendMessage);
  }
  void _onLoadMessages(LoadMessages event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    _subscription?.cancel();
    _subscription = chatRepository
        .getMessages(event.eventId)
        .listen(
          (messages) => emit(ChatLoaded(messages)),
          onError: (error) => emit(ChatError(error.toString())),
        );
  }

  Future<void> onSendMessage(SendMessageEvent event, Emitter<ChatState> emit) async {
    try {
      await chatRepository.sendMessage(event.message, event.eventId);
    } catch (e) {
      emit(ChatError("Failed to send message: $e"));
    }
  }

  // onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
  //   await chatRepository.sendMessage(event.message, event.eventId);
  // }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
