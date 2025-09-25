part of 'programs_bloc.dart';

class ProgramsEvent {}

class AddProgramEvent extends ProgramsEvent {
  final ProgramModel programmodel;
  final String ID;
  AddProgramEvent({required this.programmodel, required this.ID});
}

class GetProgramsEvent extends ProgramsEvent {
  final String Id;
  // List<ProgramModel>programs;

  GetProgramsEvent(this.Id);
}

class UpdateProgram extends ProgramsEvent {
  final ProgramModel progrmmodel;
  final String ID;

  UpdateProgram(this.ID, {required this.progrmmodel});
}

class DeleteProgram extends ProgramsEvent {
final String programid;
  final String ID;

  DeleteProgram({required this.programid, required this.ID});
}
class ReorderEvents extends ProgramsEvent {
  final String ID;       // Event ID for Firestore
  final int oldIndex;
  final int newIndex;

  ReorderEvents({
    required this.ID,
    required this.oldIndex,
    required this.newIndex,
  });
}
class PickedStartTime extends ProgramsEvent {
  final TimeOfDay time;
  PickedStartTime(this.time);
}

