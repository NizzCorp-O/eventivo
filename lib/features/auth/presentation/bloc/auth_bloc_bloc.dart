import 'package:bloc/bloc.dart';
import 'package:eventivo/features/auth/data/models/login_model.dart';
import 'package:eventivo/features/auth/data/repositories/Login_services.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final LoginServices authService = LoginServices();
  AuthBlocBloc() : super(AuthBlocInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authService.onRegister(
          LoginModel(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );
        emit(AuthSuccess());
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
  }
}
