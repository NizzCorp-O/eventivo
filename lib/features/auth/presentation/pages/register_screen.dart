import 'package:eventivo/features/Events/Presentation/screens/home_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_screen.dart';
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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Center(
        child: Form(
          key: _formKey,

          child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ParticipantScreen()),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (value) => InputValidator.validateName(value),
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    validator: (value) => InputValidator.validateEmail(value),
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) =>
                        InputValidator.validatePassword(value),
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) =>
                        InputValidator.validateConfirmPassword(
                          value,
                          passwordController.text,
                        ),
                    controller: confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'confirm password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBlocBloc>().add(
                          SignUpEvent(
                            nameController.text,
                            confirmPasswordController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please fix the errors in red"),
                          ),
                        );
                      }
                    },
                    child: Text('Register'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text("login"),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
