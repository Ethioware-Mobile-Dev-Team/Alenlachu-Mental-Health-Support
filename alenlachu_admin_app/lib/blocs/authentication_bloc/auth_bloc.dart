import 'package:alenlachu_admin_app/data/services/authentication/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices;

  AuthBloc(this._authServices) : super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

// mapping events and states
  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final currentUser = await _authServices.getCurrentUser();
    if (currentUser != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) async {
    final currentUser = await _authServices.getCurrentUser();
    if (currentUser != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authServices.signInWithEmailAndPassword(
          event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authServices.createUserWithEmailAndPassword(
          event.name, event.email, event.password);
      emit(Authenticated());
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await _authServices.signOut();
    emit(Unauthenticated());
  }
}
