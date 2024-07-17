import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final UserModel? user;
  Authenticated({required this.user});

  @override
  List<Object> get props => [user!];
}

class Unauthenticated extends AuthenticationState {}

class Authenticating extends AuthenticationState {}

class AuthenticationFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class VerifyPhoneAuthenticationCode extends AuthenticationState {
  final String verficationId;
  VerifyPhoneAuthenticationCode(this.verficationId);

  @override
  List<Object> get props => [verficationId];
}
