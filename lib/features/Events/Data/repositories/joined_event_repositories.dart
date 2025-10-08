import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventRepository {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getJoinedEvents() async {
    final userId = _auth.currentUser!.uid;

    // Get user's joined event IDs
    final userDoc = await _firestore.collection('users').doc(userId).get();
    final joinedEventIds = List<String>.from(userDoc['joinedEvents'] ?? []);

    if (joinedEventIds.isEmpty) return [];

    // Fetch events with those IDs
    final eventSnapshots = await _firestore
        .collection('events')
        .where(FieldPath.documentId, whereIn: joinedEventIds)
        .get();

    return eventSnapshots.docs.map((doc) => doc.data()).toList();
  }
}
