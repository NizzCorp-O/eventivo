import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:flutter/material.dart';

class ContainerButton extends StatelessWidget {
  final String title;
  final Color? background;
  final void Function()? onPressed;
  const ContainerButton({
    super.key,
    required this.title,
    this.onPressed,
    this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Colors.grey),
          ],
        
          gradient:  LinearGradient(
            colors: [
              ColorConstant.GradientColor1,
              ColorConstant.GradientColor2,
            ],
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
      ),
    );
  }
}
