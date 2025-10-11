
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/auth/data/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class LoginServices {
  // ===========================
  // 🔹 USER REGISTRATION
  // ===========================
  Future<void> onRegister(LoginModel log) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: log.email, password: log.pass);

      final user = credential.user;
      if (user == null) {
        throw Exception("User creation failed");
      }

      await user.updateDisplayName(log.name);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        "name": log.name,
        "email": log.email,
        "phone": log.phone,
        "role": "participant",
        "createdAt": FieldValue.serverTimestamp(),
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("The account already exists for that email.");
      } else {
        throw Exception(e.message ?? "Registration failed.");
      }
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // ===========================
  // 🔹 USER LOGIN
  // ===========================
  Future<String> onLogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = credential.user!.uid;

      final userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get();

      if (!userDoc.exists) {
        throw Exception("User profile not found in Firestore");
      }

      return userDoc["role"]; // return admin / participant
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("No user found for this email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Incorrect password provided.");
      } else {
        throw Exception(e.message ?? "Login failed.");
      }
    } catch (e) {
      throw Exception("Something went wrong: $e");
    }
  }

  // ===========================
  // 🔹 PASSWORD RESET
  // ===========================
  Future<void> sendPasswordReset(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent!');
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
    }
  }

  // ===========================
  // 🔹 UPDATE PROFILE IMAGE
  // ===========================
  Future<String> updateUserProfileImage(File file, String userId) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
        "profile_images/$userId.jpg",
      );
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection("users").doc(userId).set({
        "profileImage": downloadUrl,
      }, SetOptions(merge: true));

      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to update profile image: $e");
    }
  }

  // ===========================
  // 🔹 ADD JOINED EVENT
  // ===========================
  // 🔹 ADD JOINED EVENT
  // ===========================
  Future<void> addJoinedEventSummary(EventModel event) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      final joinedEventsRef = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('joined_events');

      await joinedEventsRef.doc(event.id).set({
        'eventId': event.id,
        'title': event.name,
        'startTime': event.startTime,
        'date': event.date,
        'profileImage': event.imageUrls.isNotEmpty ? event.imageUrls[0] : '',
        'joinedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Failed to add joined event summary: $e");
    }
  }

  // ===========================
  // 🔹 GET JOINED EVENTS
  // ===========================
  Future<List<EventModel>> getJoinedEvents() async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;

      // Step 1: Get joined event IDs
      final joinedSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('joined_events')
          .get();

      final joinedEventIds = joinedSnapshot.docs.map((doc) => doc.id).toList();

      // Step 2: Fetch full event details
      List<EventModel> events = [];
      for (String eventId in joinedEventIds) {
        final eventDoc = await FirebaseFirestore.instance
            .collection('events')
            .doc(eventId)
            .get();

        if (eventDoc.exists) {
          events.add(EventModel.fromMap(eventDoc.id, eventDoc.data()!));
        }
      }

      return events;
    } catch (e) {
      throw Exception("Failed to fetch joined events: $e");
    }
  }

  // ===========================
  // 🔹 STREAM JOINED EVENTS
  // ===========================
  // Stream<List<EventModel>> streamJoinedEvents() {
  //   final userId = FirebaseAuth.instance.currentUser!.uid;

  //   return FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('joined_events')
  //       .orderBy('createdAt', descending: true)
  //       .snapshots()
  //       .map(
  //         (snapshot) => snapshot.docs
  //             .map((doc) => EventModel.fromMap(doc.id, doc.data()))
  //             .toList(),
  //       );
  // }
}
