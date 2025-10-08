// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ScannedTicketsScreen extends StatelessWidget {
//   const ScannedTicketsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final CollectionReference scannedCollection = FirebaseFirestore.instance
//         .collection('tickets');

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Scanned Tickets"),
//         backgroundColor: Colors.blue,
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: scannedCollection
//             .orderBy('scannedAt', descending: true)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text("Error loading tickets"));
//           }
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) {
//             return const Center(child: Text("No tickets scanned yet"));
//           }

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               final data = docs[index].data() as Map<String, dynamic>;

//               final userName = data['userName'] ?? "Unknown";
//               final attendees = data['attendees'] ?? 0;
//               final paymentId = data['paymentId'] ?? "N/A";
//               final rawCode = data['rawCode'] ?? "";

//               return Card(
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: ListTile(
//                   leading: const Icon(Icons.qr_code, color: Colors.blue),
//                   title: Text(userName),
//                   subtitle: Text(
//                     "Attendees: $attendees\nPayment ID: $paymentId",
//                   ),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.copy),
//                     onPressed: () {
//                       // Copy rawCode to clipboard
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Code copied!")),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
