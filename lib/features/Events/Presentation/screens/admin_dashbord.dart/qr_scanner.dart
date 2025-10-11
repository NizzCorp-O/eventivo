// import 'dart:convert';
// import 'dart:developer';
// import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
// import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/scanned_tickets_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class QrScanner extends StatefulWidget {
//   final String eventid;
//   const QrScanner({super.key, required this.eventid});

//   @override
//   State<QrScanner> createState() => _QrScannerState();
// }

// class _QrScannerState extends State<QrScanner> {
//   List<Map<String, dynamic>> scannedTickets = [];
//   final MobileScannerController _controller = MobileScannerController();
//   bool _isProcessing = false;

//   // Save tickets in `tickets` collection
//   final CollectionReference ticketsCollection = FirebaseFirestore.instance
//       .collection('tickets');

//   @override
//   void initState() {
//     super.initState();
//     _loadScannedCodesFromFirestore();
//   }

//   void _loadScannedCodesFromFirestore() async {
//     final snapshot = await ticketsCollection.get();

//     setState(() {
//       scannedTickets = snapshot.docs.map((doc) {
//         final data = doc.data() as Map<String, dynamic>;
//         return {
//           "rawCode": data['rawCode'] ?? "",
//           "userName": data['userName'] ?? "",
//           "attendees": data['attendees'] ?? 0,
//         };
//       }).toList();
//     });
//   }

//   void _onDetect(BarcodeCapture capture) async {
//     if (_isProcessing) return;
//     _isProcessing = true;

//     for (final barcode in capture.barcodes) {
//       String? code = barcode.rawValue;

//       if (code != null && code.trim().isNotEmpty) {
//         code = code.trim();
//         await _controller.stop();

//         String paymentId = "";
//         int attendees = 0;
//         String userName = "";
//         String eventId = "";

//         try {
//           log("Decoded code: $code");
//           final data = Map<String, dynamic>.from(jsonDecode(code));
//           paymentId = data["paymentId"]?.toString() ?? "";
//           attendees = int.tryParse(data["attendees"]?.toString() ?? "0") ?? 0;
//           userName = data["userName"]?.toString() ?? "";
//         } catch (e) {
//           final parts = code.split(";");
//           for (var part in parts) {
//             final kv = part.split(":");
//             if (kv.length == 2) {
//               final key = kv[0].trim().toLowerCase();
//               final value = kv[1].trim();

//               if (key == "paymentId") paymentId = value;
//               if (key == "attendees") attendees = int.tryParse(value) ?? 0;
//               if (key == "userName") userName = value;
//               if (key == "eventId") eventId = value;
//             }
//           }
//         }

//         if (scannedTickets.any((ticket) => ticket['rawCode'] == code)) {
//           _showSnack("⚠️ Already scanned", Colors.red);
//         } else {
//           log("---$paymentId---$attendees---$userName ---$eventId ");
//           await ticketsCollection.add({
//             "eventId": eventId,
//             'paymentId': paymentId,
//             'attendees': attendees,
//             'userName': userName,
//             'rawCode': code,
//             'scannedAt': FieldValue.serverTimestamp(),
//           });
//           _showSnack(
//             "✅ Ticket Saved\nName: $userName\nAttendees: $attendees",
//             Colors.green,
//           );
//           setState(() {
//             scannedTickets.add({
//               "rawCode": code!,
//               "userName": userName,
//               "attendees": attendees,
//               "eventId": eventId,
//             });
//           });
//         }
//       }
//     }

//     Future.delayed(const Duration(seconds: 1), () {
//       _controller.start();
//       _isProcessing = false;
//     }).then((value) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ScannedTickets(eventId: "", title: ""),
//         ),
//       );
//     });
//   }

//   void _showSnack(String message, Color color) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         duration: const Duration(seconds: 3),
//         backgroundColor: color,
//         behavior: SnackBarBehavior.floating,
//         margin: const EdgeInsets.all(12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         content: Text(
//           message,
//           style: const TextStyle(color: ColorConstant.MainWhite),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back, color: ColorConstant.MainWhite),
//         ),
//         title: const Text("QR Code Scanner"),
//         backgroundColor: ColorConstant.GradientColor1,
//       ),
//       body: Column(
//         children: [
//           // Top Half Camera
//           Expanded(
//             flex: 1,
//             child: MobileScanner(controller: _controller, onDetect: _onDetect),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:developer';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/scanned_tickets_screen.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QrScanner extends StatefulWidget {
  final String eventid;
  const QrScanner({super.key, required this.eventid});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  List<Map<String, dynamic>> scannedTickets = [];
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  // Each event has a subcollection 'tickets'
  late final CollectionReference ticketsCollection = FirebaseFirestore.instance
      .collection('events')
      .doc(widget.eventid)
      .collection('tickets');

  @override
  void initState() {
    super.initState();
    _loadScannedCodesFromFirestore();
  }

  void _loadScannedCodesFromFirestore() async {
    final snapshot = await ticketsCollection.get();
    setState(() {
      scannedTickets = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          "rawCode": data['rawCode'] ?? "",
          "userName": data['userName'] ?? "",
          "attendees": data['attendees'] ?? 0,
          "eventId": data['eventId'] ?? "",
        };
      }).toList();
    });
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;
    _isProcessing = true;

    for (final barcode in capture.barcodes) {
      String? code = barcode.rawValue;

      if (code != null && code.trim().isNotEmpty) {
        code = code.trim();
        await _controller.stop();

        String paymentId = "";
        int attendees = 0;
        String userName = "";
        String eventId = "";

        try {
          log("Decoded code: $code");
          final data = Map<String, dynamic>.from(jsonDecode(code));
          paymentId = data["paymentId"]?.toString() ?? "";
          attendees = int.tryParse(data["attendees"]?.toString() ?? "0") ?? 0;
          userName = data["userName"]?.toString() ?? "";
          eventId = data["eventid"]?.toString() ?? ""; // ✅ from QR
        } catch (e) {
          log("Error decoding QR: $e");
        }

        // 🔍 Check if event IDs match
        if (eventId != widget.eventid) {
          _showSnack("❌ Invalid Event Ticket", Colors.red);
          _controller.start();
          _isProcessing = false;
          return;
        }

        // 🔍 Check if already scanned
        if (scannedTickets.any((ticket) => ticket['rawCode'] == code)) {
          _showSnack("⚠️ Already Scanned", Colors.orange);
        } else {
          log("---$paymentId---$attendees---$userName ---$eventId");

          // Save to the correct subcollection
          await ticketsCollection.add({
            "eventId": eventId,
            'paymentId': paymentId,
            'attendees': attendees,
            'userName': userName,
            'rawCode': code,
            'scannedAt': FieldValue.serverTimestamp(),
          });

          _showSnack(
            "✅ Ticket Scanned\nName: $userName\nAttendees: $attendees",
            Colors.green,
          );

          setState(() {
            scannedTickets.add({
              "rawCode": code!,
              "userName": userName,
              "attendees": attendees,
              "eventId": eventId,
            });
          });
        }

        Future.delayed(const Duration(seconds: 1), () {
          _controller.start();
          _isProcessing = false;
        }).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScannedTickets(
                eventId: widget.eventid,
                title: "Scanned Tickets",
              ),
            ),
          );
        });
      }
    }
  }

  void _showSnack(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          message,
          style: const TextStyle(color: ColorConstant.MainWhite),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: ColorConstant.MainWhite),
        ),
        title: const Text("QR Code Scanner"),
        backgroundColor: ColorConstant.GradientColor1,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: MobileScanner(controller: _controller, onDetect: _onDetect),
          ),
        ],
      ),
    );
  }
}
