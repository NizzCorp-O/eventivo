part of 'auth_bloc_bloc.dart';

class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthSuccess extends AuthBlocState {
  final String? role;

  AuthSuccess({this.role});
}

class AuthError extends AuthBlocState {
  final String message;

  AuthError({this.message = "An error occurred"});
}
class AuthPasswordResetEmailSent extends AuthBlocState {}
