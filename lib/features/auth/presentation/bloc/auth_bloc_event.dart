part of 'auth_bloc_bloc.dart';

class AuthBlocEvent {}

class LoginEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class SignUpEvent extends AuthBlocEvent {
 final LoginModel login;

  SignUpEvent({required this.login});
}
class Resetpassword extends AuthBlocEvent{
final  String email;

  Resetpassword({required this.email});

}
class LoadProfileImageEvent extends AuthBlocEvent {}

class PickProfileImageEvent extends AuthBlocEvent {}
class UpdateProfileImageEvent extends AuthBlocEvent {
  final File imageFile;
  final String userId;

  UpdateProfileImageEvent(this.imageFile, this.userId);
}

///🔹 New Events for Joined Events
// 🔹 Joined Events
class AddJoinedEvent extends AuthBlocEvent {
  final EventModel event;
  AddJoinedEvent({required this.event});
}

class FetchJoinedEvents extends AuthBlocEvent {}

class StreamJoinedEvents extends AuthBlocEvent {}