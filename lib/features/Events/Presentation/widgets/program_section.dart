import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class Program_section extends StatelessWidget {
  final String programtitle;
  final String programdesc;
  final void Function()? onEdit;
  final void Function()? onDelete;
  const Program_section({
    super.key,
    required this.programtitle,
    required this.programdesc,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: ColorConstant.MainWhite,
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(width: 1, color: ColorConstant.InputBorder),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Icon(
                  Icons.grid_view_outlined,
                  color: ColorConstant.GradientColor1,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.visible,
                      programtitle,
                      style: TextStyle(
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Text("10:00AM"),
                        SizedBox(width: 5),
                        Text("to"),
                        SizedBox(width: 5),
                        Text("11:00AM"),
                      ],
                    ),
                  ],
                ),
              ),

              InkWell(
                onTap: onEdit,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Icon(
                    Icons.edit_square,
                    color: ColorConstant.MainBlack,
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: onDelete,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.red.shade100,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Icon(Icons.delete, color: Color(0xFFDC2626)),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(programdesc),
        ],
      ),
    );
  }
}
