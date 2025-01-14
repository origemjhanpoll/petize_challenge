import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/services/api/model/repo_api_model.dart';

import 'package:petize_challenge/modules/user/data/services/api/model/user_api_model.dart';
import 'package:petize_challenge/utils/extract_message.dart';

class UserApiService {
  final _log = Logger('UserApiService');

  Future<UserApiModel> getUser({required String user}) async {
    final uri = Uri.parse('https://api.github.com/users/$user');

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserApiModel.fromJson(data);
        _log.fine('Success user: $uri');
        return user;
      } else {
        _log.severe('Error user: $uri');

        throw HttpException(
            "Invalid response: ${response.statusCode}\n${extractMessage(response.body)}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RepoApiModel>> getRepos({
    required String url,
    String? sort,
    String? direction,
    int? perPage,
    int? page,
  }) async {
    final uri = Uri.parse(url).replace(queryParameters: {
      'sort': sort ?? 'updated',
      'direction': direction ?? 'desc',
      'per_page': perPage != null ? perPage.toString() : '10',
      'page': page != null ? page.toString() : '1',
    });

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final repos = data.map((json) => RepoApiModel.fromJson(json)).toList();
        _log.fine('Success repo: $uri');
        return repos;
      } else {
        _log.severe('Error repo: $uri');
        throw HttpException("Invalid response: ${response.statusCode}");
      }
    } catch (e) {
      _log.severe('Error repo: $uri');
      rethrow;
    }
  }
}
