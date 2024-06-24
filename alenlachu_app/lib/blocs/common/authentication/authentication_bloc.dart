import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_state.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:alenlachu_app/presentation/common/widgets/show_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthServices _authServices;

  AuthenticationBloc(this._authServices) : super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    final currentUser = await _authServices.getCurrentUser();
    if (currentUser != null) {
      emit(Authenticated(
          user: await _authServices.getUserModel(currentUser.uid)));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    final currentUser = await _authServices.getCurrentUser();
    if (currentUser != null) {
      emit(Authenticated(
          user: await _authServices.getUserModel(currentUser.uid)));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLoginRequested(
      LoginRequested event, Emitter<AuthenticationState> emit) async {
    emit(Authenticating());
    UserModel? user = await _authServices.signInWithEmailAndPassword(
        event.email, event.password);
    if (user != null) {
      showToast("User Authenticated");
      emit(Authenticated(user: user));
    } else {
      showToast("Unauthenticated");
      emit(Unauthenticated());
    }
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthenticationState> emit) async {
    emit(Authenticating());
    UserModel? user = await _authServices.createUserWithEmailAndPassword(
        event.name, event.email, event.password);
    if (user != null) {
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    await _authServices.signOut();
    emit(Unauthenticated());
  }
}
