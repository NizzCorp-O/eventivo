import 'dart:io';
import 'package:eventivo/features/Events/Data/models/Program_model.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  XFile? imagefile;
  List<String> imageUrls = [];
  List<XFile> imageslist = [];

  // Create event in Firestore
  Future<EventModel> createEvent(EventModel event) async {
    final docRef = FirebaseFirestore.instance.collection('events').doc();
    final eventId = docRef.id;

    final newEvent = event.copyWith(id: eventId);
    await docRef.set(newEvent.toMap());

    return newEvent;
  }

  // Pick multiple images
  Future<void> pickMedia() async {
    final pickedFiles = await ImagePicker().pickMultipleMedia();

    // if (pickedFiles.isEmpty) {}
    final remaining = 5 - imageslist.length;
    final limitedFiles = pickedFiles.take(remaining);
    for (var file in limitedFiles) {
      // Stop adding more if limit is reached

      final localFile = File(file.path);
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ext = file.name.split('.').last;
      final ref = FirebaseStorage.instance.ref().child(
        'event_images/$fileName.$ext',
      );

      await ref.putFile(localFile);
      final url = await ref.getDownloadURL();

      imageslist.add(file);
      imageUrls.add(url);
    }
  }

  Future<List<EventModel>> getEvents() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('events')
        .get();
    return snapshot.docs.map((doc) {
      return EventModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // Optionally remove image from list
  void removeImage(int index) {
    if (index >= 0 && index < imageslist.length) {
      imageslist.removeAt(index);
      imageUrls.removeAt(index);
    }
  }

  Future<void> deleteEvents(String eventid) async {
    final docRef = FirebaseFirestore.instance.collection('events').doc(eventid);
   await docRef.delete();
  }
}
