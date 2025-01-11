import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/data/services/api/api_client.dart';
import 'package:petize_challenge/modules/user/data/services/local/local_client_service.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/utils/network_service.dart';

class RepositoryRemote implements Repository {
  RepositoryRemote({
    required ApiClientService apiClientService,
    required LocalClientService localClientService,
  })  : _apiClientService = apiClientService,
        _localClientService = localClientService;

  final ApiClientService _apiClientService;
  final LocalClientService _localClientService;
  final NetworkService _networkService = NetworkService();

  @override
  Future<UserModel> getUser({required String user}) async {
    final internetAvailable = await _networkService.hasInternet;

    try {
      if (!internetAvailable) {
        final resultLocal = await _localClientService.loadUser();
        if (resultLocal != null) {
          return resultLocal;
        } else {
          throw Exception('No local user data found');
        }
      }

      final resultRemote = await _apiClientService.getUser(user: user);

      final userModel = UserModel(
        name: resultRemote.name,
        login: resultRemote.login,
        id: resultRemote.id,
        avatarUrl: resultRemote.avatarUrl,
        blog: resultRemote.blog,
        bio: resultRemote.bio,
        reposUrl: resultRemote.reposUrl,
        followers: resultRemote.followers,
        following: resultRemote.following,
        location: resultRemote.location,
        company: resultRemote.company,
        email: resultRemote.email,
        twitterUsername: resultRemote.twitterUsername,
      );

      _localClientService.saveUser(userModel);
      return userModel;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RepoModel>> getRepos({required String url}) async {
    final internetAvailable = await _networkService.hasInternet;

    try {
      if (!internetAvailable) {
        final resultLocal = await _localClientService.loadRepos();
        if (resultLocal != null) {
          return resultLocal;
        } else {
          throw Exception('No local repos data found');
        }
      }

      final resultRemote = await _apiClientService.getRepos(url: url);
      final reposModel = resultRemote.map((repoApi) {
        return RepoModel(
          name: repoApi.name,
          updatedAt: repoApi.updatedAt,
          description: repoApi.description,
          stargazersCount: repoApi.stargazersCount,
        );
      }).toList();

      _localClientService.saveRepos(reposModel);
      return reposModel;
    } catch (e) {
      rethrow;
    }
  }
}
