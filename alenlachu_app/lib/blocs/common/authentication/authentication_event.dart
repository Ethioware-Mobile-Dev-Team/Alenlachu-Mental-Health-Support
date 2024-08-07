import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}

class UpdateProfile extends AuthenticationEvent {
  final UserModel? user;

  UpdateProfile({this.user});
}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignUpRequested extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  SignUpRequested(
      {required this.name, required this.email, required this.password});
}

class VerifyPhoneNumber extends AuthenticationEvent {
  final String phoneNumber;
  VerifyPhoneNumber({required this.phoneNumber});
}

class SignInWithPhoneNumber extends AuthenticationEvent {
  final String verificationId;
  final String verificationCode;

  SignInWithPhoneNumber(
      {required this.verificationId, required this.verificationCode});
}
