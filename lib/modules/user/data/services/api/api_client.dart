import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:petize_challenge/modules/user/data/services/api/model/user_api_model.dart';
import 'package:petize_challenge/utils/result.dart';

class ApiClient {
  Future<Result<UserApiModel>> getUser({required String user}) async {
    final uri = Uri.parse('https://api.github.com/users/$user');

    try {
      final response =
          await http.get(uri, headers: {'Content-Type': 'application/json'});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = UserApiModel.fromJson(data);
        return Result.ok(user);
      } else {
        return Result.error(
            HttpException("Invalid response: ${response.statusCode}"));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
