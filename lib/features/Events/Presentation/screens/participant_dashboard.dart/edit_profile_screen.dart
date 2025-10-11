import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/core/constants/color_constants.dart/color_constant.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_dashboard.dart/bottom_navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? "";
    _emailController.text = user?.email ?? "";
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    final user = FirebaseAuth.instance.currentUser;
    final userId = user!.uid;

    try {
      await user.updateDisplayName(_nameController.text.trim());

      // Update Firestore user document
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        "name": _nameController.text.trim(),
        // "email": _emailController.text.trim(),
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (route) => false,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: ColorConstant.PrimaryBlue,
          content: Text("Profile updated successfully"),
        ),
      );

      setState(() {}); // go back to Profile screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error updating profile"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.MainWhite,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          backgroundColor: ColorConstant.MainWhite,
          foregroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                // const SizedBox(height: 20),
                // TextFormField(
                //   controller: _emailController,
                //   decoration: const InputDecoration(labelText: "Email"),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return "Please enter your email";
                //     }
                //     if (!RegExp(
                //       r"^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$",
                //     ).hasMatch(value)) {
                //       return "Enter a valid email";
                //     }
                //     return null;
                //   },
                // ),
                const SizedBox(height: 40),
                isLoading
                    ? const CircularProgressIndicator(
                        backgroundColor: ColorConstant.GradientColor1,
                        color: ColorConstant.MainBlack,
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstant.GradientColor1,
                          ),
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(color: ColorConstant.MainWhite),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
