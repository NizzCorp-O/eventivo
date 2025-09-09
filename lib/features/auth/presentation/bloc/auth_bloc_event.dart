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
  final String phone;
  final String password;
  final String confirmPassword;

  SignUpEvent({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirmPassword,
  });
}
class Resetpassword extends AuthBlocEvent{
final  String email;

  Resetpassword({required this.email});

}
