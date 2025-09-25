part of 'event_bloc.dart';

class EventEvent {}

// class AddProgramEvent extends EventEvent {
//   ProgramModel programmodel;
//   final String ID;
//   AddProgramEvent({required this.programmodel, required this.ID});
// }

class AddEventEvent extends EventEvent {
  EventModel eventModel;

  AddEventEvent({required this.eventModel});
}

// class GetProgramsEvent extends EventEvent {
//   final String Id;
//   // List<ProgramModel>programs;

//   GetProgramsEvent(this.Id);
// }

class getEvents extends EventEvent {}

class PickImageEvent extends EventEvent {}


class AddImageEvent extends EventEvent {
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

class PickedEndTime extends EventEvent {
  final TimeOfDay endtime;

  PickedEndTime(this.endtime);
}

class ClearDateTime extends EventEvent {}

class DeleteEvents extends EventEvent{

final String eventid;

  DeleteEvents({required this.eventid});

}

