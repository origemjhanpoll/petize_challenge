import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';

abstract class ISearchRepository {
  Future<SearchUsersModel> getUsers({required String user, required int page});
  Future<List<UserItem>?> loadRecentUsers();
  Future<void> saveRecentUser({required UserItem user});
  Future<void> clearRecentUsers();
}
