import 'dart:async';

import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/widgets/buildDot.dart';
import 'package:eventivo/features/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _activeIndex = 0;
  late Timer _timer;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 4)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
      setState(() {
        _activeIndex = (_activeIndex + 1) % 3;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.MainBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 80, left: 40, child: backgroundDot(Colors.yellow)),
            Positioned(
              top: 120,
              left: 322,
              child: backgroundDot(Colors.grey, size: 4),
            ),

            Positioned(
              top: 200,
              right: 30,
              child: backgroundDot(Colors.grey, size: 6),
            ),
            Positioned(
              top: 350,
              left: 50,
              child: backgroundDot(Colors.yellow, size: 4),
            ),
            Positioned(top: 578, left: 80, child: backgroundDot(Colors.yellow)),
            Positioned(
              bottom: 240,
              right: 70,
              child: backgroundDot(Colors.grey, size: 6),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Logo.png"),

                      SizedBox(height: 10),
                      Text(
                        "EVENTIVO",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.MainWhite,
                          fontSize: 36,
                          letterSpacing: 1.8,
                        ),
                      ),

                      Text(
                        textAlign: TextAlign.center,
                        "ELEGANT PLANNER",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Color(0xFFC0C0C0),
                          fontSize: 18,
                          letterSpacing: 1.8,
                          height: 2.8,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Seamless planning for unforgettable \nmoments.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFFFFFF).withOpacity(0.7),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Loading",
                          style: TextStyle(
                            color: Color(0xFFFFFF).withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 8),
                        ...List.generate(3, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: BuildDot(isActive: index == _activeIndex),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        color: Color(0xFFFFFF).withOpacity(0.4),
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget backgroundDot(Color color, {double size = 8.0}) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
