import 'package:flutter/material.dart';

class BuildDot extends StatelessWidget {
  final bool isActive;

  const BuildDot({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: isActive ? 8 : 6,
      width: isActive ? 8 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.yellow[700] : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }
}


