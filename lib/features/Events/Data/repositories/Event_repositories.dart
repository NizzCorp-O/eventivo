import 'dart:io';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import your EventModel class

class EventRepository {
  XFile? imagefile;
  List<XFile> imageslist = [];

  // Create event in Firestore
  Future<void> createEvent(EventModel event) async {
    await FirebaseFirestore.instance.collection('events').add(event.toMap());
  }

  // Pick image from gallery and upload to Firebase Storage
  Future<void> pickMedia() async {
    final imagefile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (imagefile == null) {
      throw Exception("No image selected");
    }

    final file = File(imagefile.path);

    // unique file name
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ext = imagefile.name.split('.').last;

    // Firebase Storage reference
    final ref = FirebaseStorage.instance.ref().child(
      'event_images/$fileName.$ext',
    );

    // upload file
    await ref.putFile(file);

    // get download URL
    final url = await ref.getDownloadURL();
    print("Uploaded ✅ URL: $url");

    // add to images list
    imageslist.add(imagefile);
    print("IMGES LIST$imageslist");
  }

  // Optionally remove image from list
  void removeImage(XFile image) {
    imageslist.remove(image);
  }
}
