part of 'event_bloc.dart';

class EventEvent {}

class AddEventEvent extends EventEvent {
  EventModel eventModel;

  AddEventEvent({required this.eventModel});
}
class getEvents extends EventEvent{


}
class PickImageEvent extends EventEvent {
  
}
class AddImageEvent extends EventEvent{

final XFile image;  
AddImageEvent(this.image);

}

class RemoveImageEvent extends EventEvent {
  final int index;

  RemoveImageEvent({required this.index});
}

class UploadImagesEvent extends EventEvent {
  final List<XFile> images;

  UploadImagesEvent({required this.images});
}

class PickDate extends EventEvent {
  final DateTime date;
  PickDate(this.date);
}

class PickedStartTime extends EventEvent {
  final TimeOfDay time;
  PickedStartTime(this.time);
}
class PickedEndTime extends EventEvent{
  final TimeOfDay endtime;

  PickedEndTime( this.endtime);
  
}

class ClearDateTime extends EventEvent {}
