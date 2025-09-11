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
        .orderBy('title') // optional
        .get(); // fetch once

    final programs = snapshot.docs
        .map((doc) => ProgramModel.fromMap(doc.id, doc.data()))
        .toList();

    return programs;
  }
}
