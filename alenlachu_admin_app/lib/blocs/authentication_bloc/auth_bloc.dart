import 'package:alenlachu_admin_app/data/services/authentication/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthServices _authServices;

  AuthBloc(this._authServices) : super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
  }
}
