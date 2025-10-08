import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadQrToStorage(
  String eventId,
  String userId,
  Uint8List qrBytes,
) async {
  final storageRef = FirebaseStorage.instance
      .ref()
      .child("tickets_qr") // Folder name
      .child(eventId) // Event-specific folder
      .child("$userId.png"); // File name

  await storageRef.putData(qrBytes, SettableMetadata(contentType: "image/png"));

  return await storageRef.getDownloadURL(); // QR image URL
}
