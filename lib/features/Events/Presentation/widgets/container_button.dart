import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const ContainerButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorConstant.GradientColor1, ColorConstant.GradientColor2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          minimumSize: Size(double.infinity, 56),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorConstant.MainWhite,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
