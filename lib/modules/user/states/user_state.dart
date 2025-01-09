import 'package:petize_challenge/modules/user/models/user_model.dart';

class UserState {
  final UserModel user;
  final List repos;

  UserState({
    required this.user,
    required this.repos,
  });

  factory UserState.init() {
    return UserState(
      user: UserModel.init(),
      repos: [],
    );
  }
}
