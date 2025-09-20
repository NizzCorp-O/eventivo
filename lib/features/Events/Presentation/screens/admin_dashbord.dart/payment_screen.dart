import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/core/utils%20/fonts.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        backgroundColor: ColorConstant.MainWhite,
        centerTitle: true,
        title: Text(
          "Payment",
          style: TextStyle(
            fontFamily: CustomFontss.fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.InputBorder,
                      blurRadius: 10,
                      offset: Offset(1, 1),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  border: BoxBorder.all(
                    width: 0,
                    color: ColorConstant.InputBorder,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://images.pexels.com/photos/1181355/pexels-photo-1181355.jpeg",
                          ),
                        ),
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 16,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Premium Business Summit 2024",
                            style: TextStyle(
                              fontFamily: CustomFontss.fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: ColorConstant.GradientColor1,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "March 15 ,2025",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                radius: 5,

                                backgroundColor: Colors.black,
                              ),
                              SizedBox(width: 10),
                              Text("9:00 AM ", style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          SizedBox(height: 14),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: ColorConstant.GradientColor1,
                                size: 26,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Grand convention center",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFF9FAFB),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Number of participants ",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: CustomFontss.fontFamily,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 10),

                    Container(
                      decoration: BoxDecoration(
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        color: ColorConstant.MainWhite,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 21,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person_2_outlined,
                                color: ColorConstant.GradientColor1,
                              ),
                              SizedBox(width: 5),
                              Text("Attendees"),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 40, // diameter = radius * 2
                                height: 40,
                                decoration: BoxDecoration(
                                  border: BoxBorder.all(
                                    width: 1,
                                    color: ColorConstant.InputBorder,
                                  ),
                                  color: ColorConstant.MainWhite,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.remove, color: Colors.black),
                              ),
                              SizedBox(width: 15),
                              Text("2", style: TextStyle(fontSize: 20)),
                              SizedBox(width: 15),
                              Container(
                                width: 40, // diameter = radius * 2
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorConstant
                                      .GradientColor1, // same background color
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
              child: Container(
                decoration: BoxDecoration(
                  border: BoxBorder.all(
                    width: 1,
                    color: ColorConstant.InputBorder,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 17, vertical: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price Breakdown",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: CustomFontss.fontFamily,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Ticket Price (\₹2,500 x 2)",

                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: CustomFontss.fontFamily,
                          ),
                        ),
                        Text("\₹2500", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "platform fee",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: CustomFontss.fontFamily,
                          ),
                        ),
                        Text("50", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("GST (18%)", style: TextStyle(fontSize: 16)),
                        Text("909", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(
                      color: ColorConstant.InputBorder,
                      radius: BorderRadius.circular(1),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total amount", style: TextStyle(fontSize: 16)),
                        Text("\₹5995", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    width: 1,
                    color: ColorConstant.InputBorder,
                  ),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                            fontFamily: CustomFontss.fontFamily,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          children: [
                            Text("Powered by"),
                            SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorConstant.PrimaryBlue,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              child: Text(
                                "Razorpay",
                                style: TextStyle(
                                  color: ColorConstant.MainWhite,
                                  fontFamily: CustomFontss.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.credit_card_rounded,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Credit/Debit Card",
                            style: TextStyle(fontSize: 16),
                          ),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone_android_rounded,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("UPI", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.mobile_screen_share,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("Net Banking", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: BoxBorder.all(
                          width: 1,
                          color: ColorConstant.InputBorder,
                        ),
                      ),
                      padding: EdgeInsets.all(13),
                      child: Row(
                        children: [
                          Icon(
                            Icons.wallet,
                            color: ColorConstant.GradientColor1,
                          ),
                          SizedBox(width: 5),
                          Text("Wallet", style: TextStyle(fontSize: 16)),
                          Spacer(),
                          Icon(Icons.chevron_right_sharp),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.GradientColor1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.lock, color: ColorConstant.MainWhite),
                        SizedBox(width: 5),
                        Text(
                          "Pay ₹5995 ",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: CustomFontss.fontFamily,
                            fontWeight: FontWeight.w600,
                            color: ColorConstant.MainWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 15,
                  Icons.diamond_outlined,
                  color: ColorConstant.GradientColor1,
                ),
                SizedBox(width: 5),
                Text(
                  "Secure Payment powered by Razorpay",
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
