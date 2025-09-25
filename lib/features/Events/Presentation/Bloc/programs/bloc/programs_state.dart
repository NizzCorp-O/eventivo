part of 'programs_bloc.dart';

class ProgramsState {}

final class ProgramsInitial extends ProgramsState {}

class ProgramAdded extends ProgramsState {}

class Programloading extends ProgramsState {}

class ProgramsLoaded extends ProgramsState {
  final List<ProgramModel> programs;

  ProgramsLoaded(this.programs);
}

class ProgramError extends ProgramsState {
  final String message;
  ProgramError({required this.message});
}



