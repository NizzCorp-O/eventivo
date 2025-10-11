import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/qr_scanner.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final CollectionReference ticketsCollection = FirebaseFirestore.instance
        .collection('events')
        .doc(widget.eventId)
        .collection('tickets');

    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        backgroundColor: ColorConstant.MainWhite,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Scanned Tickets",
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Stats Section
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: ticketsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Text("Error loading tickets");
                  }

                  final allTickets = snapshot.data?.docs ?? [];
                  final totalTickets = allTickets.length;

                  // ✅ Scanned tickets
                  final scannedTickets = allTickets
                      .where(
                        (doc) =>
                            (doc.data() as Map<String, dynamic>)['scannedAt'] !=
                            null,
                      )
                      .length;

                  // ✅ Pending tickets
                  final pendingTickets = totalTickets - scannedTickets;

                  // ✅ Today scanned
                  final today = DateTime.now();
                  final todayScanned = allTickets.where((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    if (data['scannedAt'] == null) return false;
                    final scannedAt = (data['scannedAt'] as Timestamp).toDate();
                    return scannedAt.year == today.year &&
                        scannedAt.month == today.month &&
                        scannedAt.day == today.day;
                  }).length;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildStat(
                          totalTickets.toString(),
                          "Totaltickets",
                          Colors.black87,
                        ),
                      ),
                      // Wrap VerticalDivider in SizedBox to give it a fixed height
                      SizedBox(
                        height: 50, // adjust according to your design
                        child: const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: _buildStat(
                          scannedTickets.toString(),
                          "Scanned",
                          Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: 50, // adjust according to your design
                        child: const VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      Expanded(
                        child: _buildStat(
                          pendingTickets.toString(),
                          "Pending",
                          Colors.orange,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            Text(
              "Recent Scans",
              style: TextStyle(
                fontFamily: CustomFontss.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),

            //  Only Scanned Tickets List
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: ticketsCollection
                    .where('scannedAt', isNotEqualTo: null)
                    .orderBy('scannedAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading tickets"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return const Center(child: Text("No scanned tickets yet"));
                  }

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final data = docs[index].data() as Map<String, dynamic>;
                      final userName = data['userName'] ?? "Unknown";
                      final attendees = data['attendees'] ?? 0;
                      final scannedAt = (data['scannedAt'] as Timestamp)
                          .toDate();

                      return _ticketTile(
                        name: userName,
                        attendees: attendees,
                        subtitle: "Scanned ${timeAgo(scannedAt)}",
                        iconColor: Colors.green.shade400,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      //Floating button for QR scan
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: ColorConstant.GradientColor1,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QrScanner(eventid: widget.eventId),
            ),
          );
        },
        child: const Icon(
          Icons.qr_code_scanner_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _ticketTile({
    required String name,
    required int attendees,
    required String subtitle,
    required Color iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: ColorConstant.InputBorder),
        color: ColorConstant.MainWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor,
            child: const Icon(
              Icons.person,
              color: ColorConstant.MainWhite,
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
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Attendees : $attendees",
                  style: TextStyle(color: ColorConstant.PrimaryBlue),
                ),

                Text(
                  subtitle,
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
  }

  Widget _buildStat(String value, String label, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
