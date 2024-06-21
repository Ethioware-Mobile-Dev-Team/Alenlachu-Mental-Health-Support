import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AdminModel extends Equatable {
  final String id;
  String name;
  final String email;
  String? photo;

  AdminModel(
      {required this.id, required this.name, required this.email, this.photo});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
    };
  }

  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return AdminModel(
        id: snapshot['id'],
        name: snapshot['name'],
        email: snapshot['email'],
        photo: snapshot['photo']);
  }

  @override
  List<Object?> get props => [id, name, email, photo];
}
