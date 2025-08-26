import 'package:eventivo/features/Events/Presentation/screens/home_screen.dart';
import 'package:eventivo/features/Events/Presentation/screens/participant_screen.dart';
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
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthBlocBloc, AuthBlocState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Logging in...')));
                }
                if (state is AuthSuccess) {
                  if (state.role == 'admin') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminScreen(), // Admin home
                      ),
                    );
                  } else
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParticipantScreen(),
                      ),
                    );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Login failed. Please try again.')),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: (value) => InputValidator.validateEmail(value),
                      controller: emailController,
                      decoration: InputDecoration(labelText: 'Email address'),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          InputValidator.validatePassword(value),
                      controller: passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBlocBloc>(context).add(
                            LoginEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login failed. Please try again.'),
                            ),
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            },
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
