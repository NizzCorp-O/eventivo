part of 'event_bloc.dart';

abstract class EventState {}

class EventInitial extends EventState {}

class EventLoaded extends EventState {
  final List<XFile> images;

  EventLoaded({required this.images});
}

class EventLoading extends EventState {}

class EventAdded extends EventState {}

class EventError extends EventState {
  final String message;

  EventError(this.message);
}

class UploadImages extends EventState {
  final List<String> urls;
  UploadImages(this.urls);
}
