import 'package:flutter_bloc/flutter_bloc.dart';

enum AdminBottomNavigationState { home, post, profile }

class AdminBottomNavigationCubit extends Cubit<AdminBottomNavigationState> {
  AdminBottomNavigationCubit() : super(AdminBottomNavigationState.home);

  void selectItem(AdminBottomNavigationState item) {
    emit(item);
  }
}
