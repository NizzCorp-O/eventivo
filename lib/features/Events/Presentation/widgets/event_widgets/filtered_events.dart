import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:flutter/material.dart';

class FilteredContainer extends StatelessWidget {
  final bool selectedindex;
  final String tittle;
  final IconData? icons;
  final void Function()? onTap;
  const FilteredContainer({
    super.key,
    required this.tittle,
    this.icons,
    required this.selectedindex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Row(
            children: [
              if (icons != null)
                Padding(
                  padding: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
                  child: Icon(
                    icons,
                    color: selectedindex == true
                        ? ColorConstant.MainWhite
                        : ColorConstant.GradientColor1,
                  ),
                ),
              SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 9, right: 10, top: 11),
                child: Text(
                  tittle,
                  style: TextStyle(
                    fontSize: 14,
                    color: selectedindex == true
                        ? ColorConstant.MainWhite
                        : Color(0xFF374151),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          border: selectedindex == false
              ? BoxBorder.all(width: 1, color: ColorConstant.InputBorder)
              : null,
          borderRadius: BorderRadius.circular(8),
          color: selectedindex == true
              ? ColorConstant.GradientColor1
              : Colors.transparent,
        ),
      ),
    );
  }
}
