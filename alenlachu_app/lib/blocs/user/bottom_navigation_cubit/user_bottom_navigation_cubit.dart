import 'package:flutter_bloc/flutter_bloc.dart';

enum UserBottomNavigationState { home, journal, venting, chat, profile }

class UserBottomNavigationCubit extends Cubit<UserBottomNavigationState> {
  UserBottomNavigationCubit() : super(UserBottomNavigationState.home);

  void selectItem(UserBottomNavigationState item) {
    emit(item);
  }
}
