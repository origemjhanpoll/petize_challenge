import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petize_challenge/modules/user/states/user_state.dart';

class UserController extends Cubit<UserState> {
  UserController() : super(UserState.init());

  Future<void> getUser() async {}
}
