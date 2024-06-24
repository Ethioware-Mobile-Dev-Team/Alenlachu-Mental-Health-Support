import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  final String id;
  String name;
  final String email;
  final String password;
  String? photoUrl;
  String role;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      this.photoUrl,
      this.role = "user"});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "password": password,
      "photoUrl": photoUrl,
      "role": role
    };
  }

  factory UserModel.fromSnapshot(Map<String, dynamic> snapshot) {
    return UserModel(
      id: snapshot['id'],
      name: snapshot['name'],
      email: snapshot['email'],
      password: snapshot['password'],
      photoUrl: snapshot['photoUrl'],
      role: snapshot['role'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, password, photoUrl, role];
}
