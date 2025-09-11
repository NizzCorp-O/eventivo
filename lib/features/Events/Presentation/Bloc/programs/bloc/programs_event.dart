part of 'programs_bloc.dart';

 class ProgramsEvent {}
 class AddProgramEvent extends ProgramsEvent {
  final  ProgramModel programmodel;
  final String ID;
  AddProgramEvent({required this.programmodel, required this.ID});
}
class GetProgramsEvent extends ProgramsEvent {
  final String Id;
  // List<ProgramModel>programs;

  GetProgramsEvent(this.Id);
}