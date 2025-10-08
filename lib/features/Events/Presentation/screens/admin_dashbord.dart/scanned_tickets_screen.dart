import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/qr_scanner.dart';
import 'package:eventivo/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScannedTickets extends StatefulWidget {
  const ScannedTickets({super.key});

  @override
  State<ScannedTickets> createState() => _ScannedTicketsState();
}

class _ScannedTicketsState extends State<ScannedTickets> {
  final User? user = FirebaseAuth.instance.currentUser;
  String? profileimage;
  num scannedtickets = 0;
  @override
  void initState() {
    setState(() {
      scannedtickets;
    });
    super.initState();
  }

  final Map<String, String> _profileImageCache = {}; // cache for profile images

  Future<String?> getUserProfileImage(String userId) async {
    if (userId.isEmpty) return null;

    if (_profileImageCache.containsKey(userId)) {
      return _profileImageCache[userId];
    }

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .get();

    if (doc.exists) {
      final data = doc.data();
      if (data != null && data.containsKey("profileImage")) {
        profileimage = data["profileImage"];
        _profileImageCache[userId] = profileimage!;
        return profileimage;
      }
    }

    return null; // fallback
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference scannedCollection = FirebaseFirestore.instance
        .collection('tickets');

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Scan Tickets",
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Section
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat("25".toString(), "Total Tickets", Colors.black87),
                  _buildStat("12", "Today", ColorConstant.GradientColor1),
                  _buildStat("${scannedtickets}", "Scanned", Colors.green),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Scans
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recent Scans",
                  style: TextStyle(
                    fontFamily: CustomFontss.fontFamily,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "View All",
                  style: TextStyle(
                    color: ColorConstant.GradientColor1,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),         
            // List of recent scans
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: scannedCollection
                    .orderBy('scannedAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  log("streamingggggg");
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading tickets"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;
                  log("tottal ticktes :${docs.length}");
                  scannedtickets = docs.length;
                  log("$scannedtickets");

                  if (docs.isEmpty) {
                    return Center(child: Text("No tickets scanned yet"));
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      String capitalizeFirstLetter(String text) {
                        if (text.isEmpty) return text;
                        return text[0].toUpperCase() + text.substring(1);
                      }

                      final data = docs[index].data() as Map<String, dynamic>;

                      final userName = data['userName'] ?? "Unknown";
                      final attendees = data['attendees'] ?? 0;
                      final paymentId = data['paymentId'] ?? "N/A";
                      final ticketUserId = data['userId'] ?? "";

                      return FutureBuilder<String?>(
                        future: getUserProfileImage(ticketUserId),
                        builder: (context, snapshot) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: ColorConstant.InputBorder,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  radius: 30,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalizeFirstLetter(userName),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "Attendees: $attendees",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.PrimaryBlue,
                                        ),
                                      ),
                                      Text(
                                        "Payment ID: $paymentId",
                                        style: TextStyle(
                                          color: ColorConstant.PrimaryBlue,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.GradientColor1,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Button
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FloatingActionButton(
          elevation: 5,
          shape: const CircleBorder(),
          backgroundColor: ColorConstant.GradientColor1,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const QrScanner()),
              (Route<dynamic> route) => false,
            );
          },
          child: const Icon(Icons.qr_code_sharp, color: Colors.white, size: 40),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}
