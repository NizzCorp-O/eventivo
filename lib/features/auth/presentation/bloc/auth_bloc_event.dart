part of 'auth_bloc_bloc.dart';

class AuthBlocEvent {}

class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthBlocEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpEvent(
    this.name,
    this.confirmPassword, {
    required this.email,
    required this.password,
  });
}
