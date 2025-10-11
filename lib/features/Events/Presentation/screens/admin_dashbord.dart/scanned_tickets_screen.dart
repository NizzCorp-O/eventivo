import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ScannedTickets extends StatefulWidget {
  final String eventId;
  final String title;

  const ScannedTickets({super.key, required this.eventId, required this.title});

  @override
  State<ScannedTickets> createState() => _ScannedTicketsState();
}

class _ScannedTicketsState extends State<ScannedTickets> {
  String timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
    if (diff.inHours < 24) return "${diff.inHours}h ago";
    return "${diff.inDays}d ago";
  }

  num scannedTicketsCount = 0;

  @override
  Widget build(BuildContext context) {
    final CollectionReference ticketsCollection = FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .collection('tickets'); // ✅ Fetch only tickets for this event

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
        title: Text(
          "Scanned Tickets",
          style: const TextStyle(fontWeight: FontWeight.w700),
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
              child: StreamBuilder<QuerySnapshot>(
                stream: ticketsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    scannedTicketsCount = snapshot.data!.docs.length;
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat(
                        scannedTicketsCount.toString(),
                        "Total Tickets",
                        Colors.black87,
                      ),
                      _buildStat(
                        scannedTicketsCount.toString(),
                        "Today",
                        ColorConstant.GradientColor1,
                      ),
                      _buildStat(
                        scannedTicketsCount.toString(),
                        "Scanned",
                        Colors.green,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Recent Scans
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Recent Scans",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of recent scans
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: ticketsCollection
                    .orderBy('scannedAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError)
                    return const Center(child: Text("Error loading tickets"));
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return const Center(child: CircularProgressIndicator());

                  final docs = snapshot.data!.docs;
                  if (docs.isEmpty)
                    return const Center(child: Text("No tickets scanned yet"));

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final userName = data['userName'] ?? "Unknown";
                      final attendees = data['attendees'] ?? 0;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: ColorConstant.InputBorder,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 30,
                              ),
                              radius: 30,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "Attendees: $attendees",
                                    style: TextStyle(
                                      color: ColorConstant.PrimaryBlue,
                                    ),
                                  ),
                                  Text(
                                    "Scanned ${timeAgo((data['scannedAt'] as Timestamp).toDate())}",
                                    style: TextStyle(
                                      color: ColorConstant.PrimaryBlue,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.GradientColor1,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrScanner(eventid: widget.eventId),
            ),
          );
        },
        child: const Icon(Icons.qr_code_sharp, color: Colors.white),
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

