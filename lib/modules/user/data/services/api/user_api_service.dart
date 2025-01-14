import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:petize_challenge/modules/user/data/services/api/model/repo_api_model.dart';

import 'package:petize_challenge/modules/user/data/services/api/model/user_api_model.dart';
import 'package:petize_challenge/utils/extract_message.dart';

class UserApiService {
  Future<UserApiModel> getUser({required String user}) async {
    final uri = Uri.parse('https://api.github.com/users/$user');

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserApiModel.fromJson(data);
        return user;
      } else {
        throw HttpException(
            "Invalid response: ${response.statusCode}\n${extractMessage(response.body)}");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RepoApiModel>> getRepos({required String url}) async {
    final uri = Uri.parse(url);

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final repos = data.map((json) => RepoApiModel.fromJson(json)).toList();
        return repos;
      } else {
        throw HttpException("Invalid response: ${response.statusCode}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
