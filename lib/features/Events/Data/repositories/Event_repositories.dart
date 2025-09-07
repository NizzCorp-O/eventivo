import 'dart:io';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EventRepository {
  XFile? imagefile;
  List<String> imageUrls = [];
  List<XFile> imageslist = [];

  // Create event in Firestore
  Future<void> createEvent(EventModel event) async {
    await FirebaseFirestore.instance.collection('events').add(event.toMap());
  }

  // Pick multiple images
  Future<void> pickMedia() async {
    final pickedFiles = await ImagePicker().pickMultiImage();

    if (pickedFiles.isEmpty) throw Exception("No images selected");

    for (var file in pickedFiles) {
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
    final snapshot =  await FirebaseFirestore.instance.collection('events').get();
    return snapshot.docs.map((doc) {
      return EventModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
    
    
  }

  // Optionally remove image from list
  void removeImage(XFile image) {
    imageslist.remove(image);
  }
}
