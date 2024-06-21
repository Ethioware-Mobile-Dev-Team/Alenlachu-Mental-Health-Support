import 'package:flutter_bloc/flutter_bloc.dart';

enum BottomNavigationState { home, post, profile }

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit() : super(BottomNavigationState.home);

  void selectItem(BottomNavigationState item) {
    emit(item);
  }
}
