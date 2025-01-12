import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:petize_challenge/modules/search/data/services/api/model/search_users_api_model.dart';

import 'package:petize_challenge/utils/extract_message.dart';

class SearchApiClientService {
  Future<SearchUsersApiModel> getSearchUsers(
      {required String user, required int page}) async {
    final uri = Uri.parse(
        'https://api.github.com/search/users?q=$user&per_page=30&page=$page');

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final searchUsers = SearchUsersApiModel.fromJson(data);
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
