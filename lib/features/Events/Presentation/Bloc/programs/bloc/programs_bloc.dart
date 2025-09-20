import 'package:bloc/bloc.dart';
import 'package:eventivo/features/Events/Data/models/Program_model.dart';
import 'package:eventivo/features/Events/Data/repositories/program_repositories.dart';

part 'programs_event.dart';
part 'programs_state.dart';

class ProgramsBloc extends Bloc<ProgramsEvent, ProgramsState> {
  ProgramRepositories programrepo = ProgramRepositories();
  ProgramsBloc({required this.programrepo}) : super(ProgramsInitial()) {
    on<AddProgramEvent>((event, emit) async {
      emit(Programloading());
      try {
        await programrepo.addProgram(event.ID, event.programmodel);
        final programs = await programrepo.getProgramsOnce(event.ID);
        emit(ProgramsLoaded(programs));
      } catch (e) {
        emit(ProgramError(message: "program not added"));
      }
    });
    on<GetProgramsEvent>((event, emit) async {
      emit(Programloading());
      try {
        final programs = await programrepo.getProgramsOnce(event.Id);
        emit(ProgramsLoaded(programs));
      } catch (e) {
        emit(ProgramError(message: "No progorams currently availble"));
      }
    });
    on<UpdateProgram>((event, emit) async {
      emit(Programloading());
      try {
        await programrepo.updateProgram(event.progrmmodel, event.ID);
        final programs = await programrepo.getProgramsOnce(event.ID);
        emit(ProgramsLoaded(programs));
      } catch (e) {
        emit(ProgramError(message: "update failed"));
      }
    });

    on<DeleteProgram>((event, emit) async {
      emit(Programloading());
      try {
        await programrepo.deleteProgram(event.programid, event.ID);
        final programs = await programrepo.getProgramsOnce(event.ID);
        emit(ProgramsLoaded(programs));
      } catch (e) {
        emit(ProgramError(message: "does not delete this program"));
      }
    });
on<ReorderEvents>((event, emit) async {
  if (state is ProgramsLoaded) {
    final currentState = state as ProgramsLoaded;
    final updatedList = List<ProgramModel>.from(currentState.programs);

    int newIndex = event.newIndex;
    if (newIndex > event.oldIndex) newIndex -= 1;

    final item = updatedList.removeAt(event.oldIndex);
    updatedList.insert(newIndex, item);

    // 🔥 Update Firestore order
    await programrepo.updateProgramsOrder(event.ID, updatedList);

    emit(ProgramsLoaded(updatedList));
  }
});

  }
}
