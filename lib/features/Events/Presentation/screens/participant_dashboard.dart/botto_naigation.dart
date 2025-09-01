import 'package:flutter/material.dart';

class BottoNaigation extends StatelessWidget {
  const BottoNaigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: ... (scroll cheyyunna content)
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Join Event Button (Gradient)
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFACC15),
                      Color(0xFFF59E0B),
                    ], // gold gradient
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Join Event",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),

            // Chat Button (Outlined)
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.chat_bubble_outline, color: Color(0xFFF59E0B)),
                label: Text(
                  "Chat with Coordinators",
                  style: TextStyle(
                    color: Color(0xFFF59E0B),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFFF59E0B), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
