import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class EventRepository {
  final List<XFile> imageslist = [];
  // List<XFile> get imagesList => List.unmodifiable(imagesList);
  Future<void> createEvent(EventModel event) async {
    await FirebaseFirestore.instance.collection('events').add(event.toMap());
  }

  Future<void> pickMedia() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);

      // unique file name
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      // reference to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child(
        'event_images/$fileName.jpg',
      );

      // upload
      await ref.putFile(file);

      // get download URL
      final url = await ref.getDownloadURL();

      print("Uploaded ✅ URL: $url");
    }

    // if (imageslist.length >= 5) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       backgroundColor: Colors.blueGrey,
    //       content: Text("Warning: Maximum 5 media allowed"),
    //     ),
    //   );
    // }
  }

  void removeImage(int index) {
    imageslist.removeAt(index);
  }

  Future<List<String>> uploadImages(List<XFile> images) async {
    // Map each image to a Future of its download URL
    final uploadTasks = images.map((image) async {
      final file = File(image.path);
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.jpg'; // simple unique name
      final ref = FirebaseStorage.instance.ref().child(
        'event_images/$fileName',
      );

      await ref.putFile(file); // Upload file
      return await ref.getDownloadURL(); // Get the download URL
    });

    return await Future.wait(uploadTasks);
  }
}
