import 'package:flutter/material.dart';

class ParticipantHomeScreen extends StatelessWidget {
  const ParticipantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Participant Dashboard')),
      body: Center(child: const Text('Welcome to the Participant Dashboard')),
    );
  }
}
