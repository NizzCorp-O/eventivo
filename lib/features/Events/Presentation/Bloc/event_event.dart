part of 'event_bloc.dart';

class EventEvent {}

class AddEventEvent extends EventEvent {
  EventModel eventModel;

  AddEventEvent({required this.eventModel});
}

class PickImageEvent extends EventEvent {}

class RemoveImageEvent extends EventEvent {
  final int index;

  RemoveImageEvent({required this.index});
}

class UploadImagesEvent extends EventEvent {
  final List<XFile> images;

  UploadImagesEvent({required this.images});
}
