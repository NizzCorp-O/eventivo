import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/bottom_navigation_screen.dart';
import 'package:eventivo/features/auth/data/models/login_model.dart';

import 'package:eventivo/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:eventivo/features/auth/presentation/pages/login_screen.dart';
import 'package:eventivo/features/auth/presentation/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isChecked = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorConstant.MainWhite),
      backgroundColor: ColorConstant.MainWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is RegistrationSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(), // Admin home
                  ),
                );
              }
              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Login failed. Please try again.')),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: ColorConstant.GradientColor1,
                    color: ColorConstant.MainBlack,
                  ),
                );
              }
              return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
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
                                "Create Account",

                                style: TextStyle(
                                  fontWeight: FontWeight.w700,

                                  fontFamily: "Montserrat",
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(height: 7),
                              Text(
                                "Join us and start your journey",
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
                              "Full Name",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF374151),
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              validator: (value) =>
                                  InputValidator.validateName(value),
                              controller: nameController,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: Icon(
                                  Icons.person_outline_outlined,
                                  color: ColorConstant.InputText,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ColorConstant.InputBorder,
                                  ),
                                ),
                                hintText: 'Enter your full name',
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
                                  borderSide: BorderSide(color: Colors.blue),
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
                              "Phone",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFF374151),
                              ),
                            ),
                            SizedBox(height: 7),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) =>
                                  InputValidator.validatePhone(value),
                              controller: phoneController,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: ColorConstant.InputText,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ColorConstant.InputBorder,
                                  ),
                                ),
                                hintText: 'Enter your phone number',
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
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: ColorConstant.InputText,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ColorConstant.InputBorder,
                                  ),
                                ),
                                hintText: 'Create password',
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
                            Text(
                              "Confirm Password",
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
                                  InputValidator.validateConfirmPassword(
                                    value,
                                    passwordController.text,
                                  ),
                              controller: confirmPasswordController,
                              decoration: InputDecoration(
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: ColorConstant.InputText,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: ColorConstant.InputBorder,
                                  ),
                                ),
                                hintText: 'Confirm your password',
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
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  Text("I agree to the "),
                                  Text(
                                    "Terms of Service",
                                    style: TextStyle(
                                      color: ColorConstant.GradientColor1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(" and"),
                                  Text(
                                    " Privacy Policy",
                                    style: TextStyle(
                                      color: ColorConstant.GradientColor1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
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
                                  if (_formKey.currentState!.validate()) {
                                    if (isChecked == true) {
                                      context.read<AuthBlocBloc>().add(
                                        SignUpEvent(
                                          login: LoginModel(
                                            pass: passwordController.text,
                                            name: nameController.text,
                                            email: emailController.text,
                                            phone:
                                                num.tryParse(
                                                  phoneController.text.trim(),
                                                ) ??
                                                0,
                                            "",
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Text(
                                  'Create Account',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                Text("Already have an account? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: ColorConstant.GradientColor1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      ],
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
