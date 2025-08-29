import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/screens/admin_dashbord.dart/admin_home_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/forgot_password.dart';

import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/participant_home_screen.dart';

import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/auth/presentation/pages/register_screen.dart';
import 'package:eventivo/features/auth/presentation/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.MainWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                if (state.role == 'admin') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminHomeScreen(), // Admin home
                    ),
                  );
                } else
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ParticipantHomeScreen(),
                    ),
                  );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login failed. Please try again.')),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    backgroundColor: ColorConstant.CircularProgressIndicatorBG,
                    color: ColorConstant.CircularProgressIndicator,
                  ),
                );
              }
              return SafeArea(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Icon(
                                    Icons.diamond_outlined,
                                    color: Colors.white,
                                  ),
                                  height: 80,
                                  width: 80,

                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.transparent.withOpacity(
                                          0.5,
                                        ),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(
                                          0,
                                          2,
                                        ), // changes position of shadow
                                      ),
                                    ],

                                    gradient: LinearGradient(
                                      colors: [
                                        ColorConstant.GradientColor1,
                                        ColorConstant.GradientColor2,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 24),
                                Text(
                                  "Welcome Back",

                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,

                                    fontFamily: "Montserrat",
                                    fontSize: 30,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  "Sign in to your account",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Email Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              SizedBox(height: 7),
                              TextFormField(
                                validator: (value) =>
                                    InputValidator.validateEmail(value),
                                controller: emailController,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: ColorConstant.InputText,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: ColorConstant.InputBorder,
                                    ),
                                  ),
                                  hintText: 'Enter your email',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.InputText,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                ),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                obscureText: true,
                                validator: (value) =>
                                    InputValidator.validatePassword(value),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.question_mark_outlined,
                                    color: ColorConstant.InputText,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: ColorConstant.InputBorder,
                                    ),
                                  ),
                                  hintText: 'Enter your password',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.InputText,
                                  ),
                                  suffixIcon: Icon(
                                    Icons.remove_red_eye_outlined,
                                    color: ColorConstant.InputText,
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                        color: ColorConstant.GradientColor1,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
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
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      context.read<AuthBlocBloc>().add(
                                        LoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red.shade500,
                                          content: Text('Login failed'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstant.MainWhite,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 49.5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: ColorConstant.InputBorder,
                                      thickness: 2,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Text("or"),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Divider(
                                      color: ColorConstant.InputBorder,
                                      thickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: ColorConstant.GradientColor1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
