import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';

abstract class SearchRepository {
  Future<SearchUsersModel> getUsers({required String user, required int page});
}
