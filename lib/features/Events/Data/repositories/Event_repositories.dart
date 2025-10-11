import 'dart:io';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepository {
  XFile? imagefile;
  List<String> imageUrls = [];
  List<XFile> imageslist = [];

  // Create event in Firestore

  Future<void> createEvent(EventModel event) async {
    try {
      List<String> imageUrls = [];

      // Upload all selected images to Firebase Storage
      for (var image in imageslist) {
        final file = File(image.path);
        final ref = FirebaseStorage.instance.ref().child(
          'event_images/${DateTime.now().millisecondsSinceEpoch}_${image.name}',
        );
        await ref.putFile(file);
        final downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        
      }

      // Add imageUrls into event map
      final eventData = event.toMap();
      eventData['imageUrls'] = imageUrls;

      // Save event with images to Firestore
      await FirebaseFirestore.instance
          .collection('events')
          .add(eventData)
          .asStream();
    } catch (e) {
      throw Exception("Failed to create event: $e");
    }
  }

  // Future<EventModel> createEvent(EventModel event) async {
  //   final docRef = FirebaseFirestore.instance.collection('events').doc();
  //   final eventId = docRef.id;

  //   final newEvent = event.copyWith(id: eventId);
  //   await docRef.set(newEvent.toMap());

  //   return newEvent;
  // }

  // Pick multiple images
  Future<void> pickMedia() async {
    final pickedFiles = await ImagePicker().pickMultipleMedia();

    if (pickedFiles == null || pickedFiles.isEmpty) {
      print("No image selected.");
      return;
    }

    final remaining = 5 - imageslist.length;
    final limitedFiles = pickedFiles.take(remaining);

    for (var file in limitedFiles) {
      imageslist.add(file);
      // Add instantly so UI updates
      final localFile = File(file.path);
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final ext = file.name.split('.').last;
      final ref = FirebaseStorage.instance.ref().child(
        'event_images/$fileName.$ext',
      );
      try {
        final uploadTask = ref.putFile(localFile);

        uploadTask.snapshotEvents.listen((snapshot) {
          final progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          print("Uploading ${file.name}: ${progress.toStringAsFixed(2)}%");
        });

        await uploadTask;
        final url = await ref.getDownloadURL();
        imageUrls.add(url);

        print("Upload complete: $url");
      } catch (e) {
        print("Upload failed for ${file.path}: $e");
      }
    }
  }

  Stream<List<EventModel>> getMyEvents() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('events')
        .where('createdBy', isEqualTo: userId)
        .snapshots() // 👈 real-time updates
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) => EventModel.fromMap(
                  doc.id,
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();
        });
  }

  Stream<List<EventModel>> getEvents() {
    return FirebaseFirestore.instance
        .collection('events')
        .snapshots() // 👈 Real-time updates
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return EventModel.fromMap(
              doc.id,
              doc.data() as Map<String, dynamic>,
            );
          }).toList();
        });
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
