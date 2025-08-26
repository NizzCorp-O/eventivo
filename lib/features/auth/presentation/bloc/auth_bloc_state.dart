part of 'auth_bloc_bloc.dart';

class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}

class AuthSuccess extends AuthBlocState {}

class AuthError extends AuthBlocState {
  final String message;
  AuthError({this.message = "An error occurred"});
}
