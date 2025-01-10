import 'package:petize_challenge/modules/user/data/repositories/user_repository.dart';
import 'package:petize_challenge/modules/user/data/services/local/local_data_service.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/utils/result.dart';

class UserRepositoryLocal implements UserRepository {
  UserRepositoryLocal({
    required LocalDataService localDataService,
  }) : _localDataService = localDataService;

  final LocalDataService _localDataService;

  @override
  Future<Result<UserModel>> getUser({required String user}) async {
    try {
      final UserModel? userModel = await _localDataService.loadUser();
      if (userModel != null) {
        return Result.ok(userModel);
      } else {
        return Result.error(Exception("User not found"));
      }
    } catch (e) {
      return Result.error(Exception("An error occurred: $e"));
    }
  }
}
