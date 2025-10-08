part of 'auth_bloc_bloc.dart';

class AuthBlocState {}

class AuthBlocInitial extends AuthBlocState {}

class AuthLoading extends AuthBlocState {}
class RegistrationSuccess extends AuthBlocState{}

class AuthSuccess extends AuthBlocState {
  final String? role;

  AuthSuccess({this.role});
}

class AuthError extends AuthBlocState {
  final String message;

  AuthError({this.message = "An error occurred"});
}
class AuthPasswordResetEmailSent extends AuthBlocState {}
class ProfileInitial extends AuthBlocState {}
class ProfileImageInitial extends AuthBlocState{}
class ProfileImageLoading extends AuthBlocState{}
class ProfileImageError extends AuthBlocState{
  final String message;

  ProfileImageError({required this.message});
  
}

class ProfileImagePicked extends AuthBlocState {

    final File imageFile;

  ProfileImagePicked({required this.imageFile});
    
}
class ProfilePickedError extends AuthBlocState{

  final String message;

  ProfilePickedError({required this.message});
  
}
 class ProfileImageUpdating extends AuthBlocState{}
class ProfileImageUpdated extends AuthBlocState{
  final String imageUrl;

  ProfileImageUpdated(this.imageUrl);
}

class ProfileImageUpdatingError extends AuthBlocState {
  final String error;

  ProfileImageUpdatingError(this.error);
}
class JoinedEventLoading extends AuthBlocState {}

class JoinedEventAdded extends AuthBlocState {}

class JoinedEventsLoaded extends AuthBlocState {
  final List<EventModel> joinedEvents;
  JoinedEventsLoaded(this.joinedEvents);
}

class JoinedEventError extends AuthBlocState {
  final String message;
  JoinedEventError(this.message);
}

