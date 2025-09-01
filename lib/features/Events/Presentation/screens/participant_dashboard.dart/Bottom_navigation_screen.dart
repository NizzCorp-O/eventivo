import 'package:eventivo/features/Events/Presentation/widgets/Custom_Navigation_bar.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Screens list

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: CustomBottomNav());
  }
}
