import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/utils/result.dart';

abstract class UserRepository {
  Future<Result<UserModel>> getUser({required String user});
}
