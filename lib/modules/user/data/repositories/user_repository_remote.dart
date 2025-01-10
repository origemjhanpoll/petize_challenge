import 'package:petize_challenge/modules/user/data/repositories/user_repository.dart';
import 'package:petize_challenge/modules/user/data/services/api/api_client.dart';
import 'package:petize_challenge/modules/user/data/services/api/model/user_api_model.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/utils/result.dart';

class UserRepositoryRemote implements UserRepository {
  UserRepositoryRemote({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  UserModel? _cachedData;

  @override
  Future<Result<UserModel>> getUser({required String user}) async {
    if (_cachedData != null) {
      return Future.value(Result.ok(_cachedData!));
    }

    final result = await _apiClient.getUser(user: user);
    switch (result) {
      case Ok<UserApiModel>():
        final user = UserModel(
          name: result.value.name,
          login: result.value.login,
          id: result.value.id,
          avatarUrl: result.value.avatarUrl,
          blog: result.value.blog,
          bio: result.value.bio,
          reposUrl: result.value.reposUrl,
          followers: result.value.followers,
          following: result.value.following,
          location: result.value.location,
          company: result.value.company,
          email: result.value.email,
          twitterUsername: result.value.twitterUsername,
        );
        _cachedData = user;
        return Result.ok(user);
      case Error<UserApiModel>():
        return Result.error(result.error);
    }
  }
}
