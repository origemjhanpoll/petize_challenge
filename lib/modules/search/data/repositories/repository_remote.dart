import 'package:petize_challenge/modules/search/data/repositories/repository.dart';
import 'package:petize_challenge/modules/search/data/services/api/search_api_client_service.dart';
import 'package:petize_challenge/modules/search/data/services/local/search_local_client_service.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';
import 'package:petize_challenge/utils/network_service.dart';

class SearchRepositoryRemote implements SearchRepository {
  SearchRepositoryRemote({
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
      if (!internetAvailable) {
        final resultLocal = await _localClientService.loadRecentUsers();
        if (resultLocal != null) {
          return SearchUsersModel(
            incompleteResults: false,
            totalCount: 5,
            items: resultLocal,
          );
        } else {
          throw Exception('No local user data found');
        }
      }

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

      _localClientService.saveRecentUsers(usersModel.items);
      return usersModel;
    } catch (e) {
      rethrow;
    }
  }
}
