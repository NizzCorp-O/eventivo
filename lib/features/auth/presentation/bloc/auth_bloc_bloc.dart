import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventivo/features/Events/Data/models/event_models.dart';
import 'package:eventivo/features/Events/Presentation/Bloc/event_bloc.dart';
import 'package:eventivo/features/auth/data/models/login_model.dart';
import 'package:eventivo/features/auth/data/repositories/login_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final LoginServices authService = LoginServices();
  final ImagePicker picker = ImagePicker();

  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.onRegister(event.login);
        emit(RegistrationSuccess());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final role = await authService.onLogin(event.email, event.password);
        emit(AuthSuccess(role: role));
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<Resetpassword>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.sendPasswordReset(event.email);
        emit(AuthPasswordResetEmailSent());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });
    on<PickProfileImageEvent>((event, emit) async {
      try {
        final PickedFile = await picker.pickImage(source: ImageSource.gallery);
        if (PickedFile != null) {
          print("PICKED FILE PATH : ${PickedFile.path}"); //
          emit(ProfileImagePicked(imageFile: File(PickedFile.path)));
        }
        print("PICKED FILE :$PickedFile");
      } catch (e) {
        emit(ProfilePickedError(message: "picked image failed"));
      }
    });
    on<UpdateProfileImageEvent>((event, emit) async {
      emit(ProfileImageUpdating());
      try {
        final imageUrl = await authService.updateUserProfileImage(
          event.imageFile,
          event.userId,
        );
        emit(ProfileImageUpdated(imageUrl));
      } catch (e) {
        emit(ProfileImageUpdatingError(e.toString()));
      }
    });
    on<LoadProfileImageEvent>((event, emit) async {
      emit(ProfileImageLoading());
      try {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final doc = await FirebaseFirestore.instance
            .collection("users")
            .doc(userId)
            .get();

        if (doc.exists && doc.data()!.containsKey("profileImage")) {
          emit(ProfileImageUpdated(doc.data()!["profileImage"]));
          
        } else {
          emit(ProfileImageInitial());
        }
      } catch (e) {
        emit(ProfileImageError(message: "profile image error"));
      }
    });
    ////// add joined events bloc /////////
    on<AddJoinedEvent>((event, emit) async {
      emit(JoinedEventLoading());
      try {
        await authService.addJoinedEventSummary(event.event);
        emit(JoinedEventAdded());
      } catch (e) {
        emit(JoinedEventError("Failed to add joined event: $e"));
      }
    });

    // 🔹 Fetch Joined Events
    on<FetchJoinedEvents>((event, emit) async {
      emit(JoinedEventLoading());
      try {
        final events = await authService.getJoinedEvents();

        emit(JoinedEventsLoaded(events));
        print("joined events :$event");
      } catch (e) {
        emit(JoinedEventError("Failed to fetch joined events: $e"));
      }
    });
    // 🔹 Stream Joined Events (Realtime)
    // on<StreamJoinedEvents>((event, emit) async {
    //   emit(JoinedEventLoading());
    //   try {
    //     await emit.forEach<List<EventModel>>(
    //       authService.streamJoinedEvents(),
    //       onData: (events) => JoinedEventsLoaded(events),
    //       onError: (_, __) =>
    //           JoinedEventError("Error receiving joined events stream"),
    //     );
    //   } catch (e) {
    //     emit(JoinedEventError("Stream error: $e"));
    //   }
    // });
  }
}
