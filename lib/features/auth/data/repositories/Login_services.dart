import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/auth/data/models/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginServices {
  Future<void> onRegister(LoginModel log) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: log.email,
            password: log.password,
          );

      String uid = credential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        "name": log.name,
        "email": log.email,
        "password": log.password,
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

  Future<void> onLogin(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
}
