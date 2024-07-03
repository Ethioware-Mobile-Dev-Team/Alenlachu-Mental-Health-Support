import 'dart:io';

import 'package:alenlachu_app/blocs/common/authentication/authentication_bloc.dart';
import 'package:alenlachu_app/blocs/common/authentication/authentication_event.dart';
import 'package:alenlachu_app/blocs/common/profile/profile_state.dart';
import 'package:alenlachu_app/data/common/models/user_model.dart';
import 'package:alenlachu_app/data/common/services/authentication/authentication_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthServices _authServices;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();
  final AuthenticationBloc _authBloc;

  ProfileCubit(this._authServices, this._authBloc) : super(ProfileInitial());

  Future<void> pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(ImagePicked(image: pickedFile.path));
      }
    } catch (e) {
      emit(NotUpdated('Failed to pick image: ${e.toString()}'));
    }
  }

  Future<void> updateName(String name) async {
    try {
      emit(Updating());
      UserModel? user = await _authServices.getUserModel();
      if (user != null) {
        user.name = name;
        await _authServices.updateProfile(user);
        emit(Updated());
        _authBloc.add(UpdateProfile(user: user));
      }
    } catch (e) {
      emit(NotUpdated(e.toString()));
    }
  }

  Future<void> updateProfile({String? imageFilePath}) async {
    emit(Updating());
    String? imageUrl;
    UserModel? user = await _authServices.getUserModel();
    try {
      if (imageFilePath != null) {
        if (user!.photoUrl != null) {
          final storageRef =
              _storage.ref().child('profile_pics/${user.id}.jpg');
          await storageRef.delete();
          user.photoUrl = null;
        }
      }
    } catch (e) {
      emit(NotUpdated(e.toString()));
    } finally {
      emit(Updating());
      final ref =
          _storage.ref().child('profile_images').child('${user!.id}.jpg');
      await ref.putFile(File(imageFilePath!));
      imageUrl = await ref.getDownloadURL();

      user.photoUrl = imageUrl;
      await _authServices.updateProfile(user);
      emit(Updated());
      _authBloc.add(UpdateProfile(user: user));
    }
  }
}
