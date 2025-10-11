import 'dart:convert';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketScreen extends StatelessWidget {
  final String eventid;
  final String user;
  final String paymentId;
  final String eventTitle;
  final num attnedees;
  final String qurl;

  const TicketScreen({
    super.key,
    required this.paymentId,
    required this.eventTitle,
    required this.attnedees,
    required this.qurl,
    required this.user, required this.eventid,
  });

  @override
  Widget build(BuildContext context) {
    final username = FirebaseAuth.instance.currentUser!.displayName;
    Map<String, dynamic> qrData = {
      "eventid":eventid,
      "paymentId": paymentId,
      "eventName": eventTitle,
      "attendees": attnedees,
      "userName": username,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(
          " Your Event Ticket ",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: ColorConstant.MainWhite),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.indigo],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      eventTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    QrImageView(
                      data: jsonEncode(qrData),
                      version: QrVersions.auto,
                      size: 220,
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.black,
                      ),
                      dataModuleStyle:  QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Payment ID: $paymentId",
                      style:  TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(height: 10),

                    Text(
                      user,
                      style:  TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
             SizedBox(height: 30),
             Text(
              "Show this QR code at the event entrance",
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
             SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orangeAccent, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.people,
                    color: ColorConstant.GradientColor2,
                    size: 22,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "Attendees: $attnedees", // make sure variable is correct
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {},

              label:  Text(
                "Please Take Screenshot",
                style: TextStyle(color: ColorConstant.MainWhite),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.GradientColor2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
