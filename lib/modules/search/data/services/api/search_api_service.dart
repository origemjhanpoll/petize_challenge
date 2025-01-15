import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/data/services/api/model/search_users_api_model.dart';

import 'package:petize_challenge/utils/extract_message.dart';

class SearchApiService {
  final _log = Logger('SearchApiService');

  Future<SearchUsersApiModel> getSearchUsers(
      {required String user, required int page}) async {
    final uri = Uri.parse(
        'https://api.github.com/search/users?q=$user&per_page=20&page=$page');

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final searchUsers = SearchUsersApiModel.fromJson(data);
        _log.fine('Success search: $uri');

        return searchUsers;
      } else {
        throw HttpException(
            "Invalid response: ${response.statusCode}\n${extractMessage(response.body)}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
