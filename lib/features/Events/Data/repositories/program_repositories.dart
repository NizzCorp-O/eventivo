import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/Program_model.dart';

class ProgramRepositories {
  Future<void> addProgram(String eventId, ProgramModel program) async {
    final docRef = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .collection('programs')
        .doc();
    await docRef.set(program.toMap());
  }

  Future<List<ProgramModel>> getProgramsOnce(String eventId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .doc(eventId)
        .collection('programs')
        .orderBy('order') // optional
        .get(); // fetch once

    final programs = snapshot.docs
        .map((doc) => ProgramModel.fromMap(doc.id, doc.data()))
        .toList();

    return programs;
  }

  Future<void> updateProgram(ProgramModel programmodel, String eventid) async {
    final docref = FirebaseFirestore.instance
        .collection("events")
        .doc(eventid)
        .collection("programs")
        .doc(programmodel.id);
    await docref.update(programmodel.toMap());
  }

  Future<void> deleteProgram(String programID, String eventid) async {
    final docref = FirebaseFirestore.instance
        .collection("events")
        .doc(eventid)
        .collection("programs")
        .doc(programID);
    await docref.delete();
  }
    Future<void> updateProgramsOrder(String eventId, List<ProgramModel> programs) async {
    final batch = FirebaseFirestore.instance.batch();

    for (int i = 0; i < programs.length; i++) {
      final updatedProgram = programs[i].copyWith(order: i);
      final docRef = FirebaseFirestore.instance
          .collection("events")
          .doc(eventId)
          .collection("programs")
          .doc(updatedProgram.id);

      batch.update(docRef, updatedProgram.toMap());
    }

    await batch.commit(); // commit all updates together
  }
}
