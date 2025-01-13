import 'package:petize_challenge/modules/search/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/search/data/services/api/search_api_client_service.dart';
import 'package:petize_challenge/modules/search/data/services/local/search_local_client_service.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';
import 'package:petize_challenge/utils/network_service.dart';

class SearchRepository implements ISearchRepository {
  SearchRepository({
    required SearchApiClientService apiClientService,
    required SearchLocalClientService localClientService,
  })  : _apiClientService = apiClientService,
        _localClientService = localClientService;

  final SearchApiClientService _apiClientService;
  final SearchLocalClientService _localClientService;
  final NetworkService _networkService = NetworkService();

  @override
  Future<SearchUsersModel> getUsers(
      {required String user, required int page}) async {
    final internetAvailable = await _networkService.hasInternet;

    try {
      if (internetAvailable) {
        final resultRemote =
            await _apiClientService.getSearchUsers(user: user, page: page);

        final usersModel = SearchUsersModel(
          totalCount: resultRemote.totalCount,
          incompleteResults: resultRemote.incompleteResults,
          items: resultRemote.items
              .map((element) => UserItem(
                    login: element.login,
                    id: element.id,
                    avatarUrl: element.avatarUrl,
                    htmlUrl: element.htmlUrl,
                  ))
              .toList(),
        );

        return usersModel;
      } else {
        throw Exception('Você está sem conexão');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserItem>?> loadRecentUsers() async {
    try {
      return await _localClientService.loadRecentUsers();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveRecentUser({required UserItem user}) async {
    try {
      return await _localClientService.saveRecentUser(user: user);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> clearRecentUsers() async {
    try {
      return await _localClientService.clearRecentUsers();
    } catch (e) {
      rethrow;
    }
  }
}
