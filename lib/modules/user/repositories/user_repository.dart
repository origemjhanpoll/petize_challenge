import 'dart:convert';
import 'dart:io';

import 'package:petize_challenge/modules/user/models/user_model.dart';
import 'package:http/http.dart';

class UserRepository {
  final client = Client();
  Future<UserModel> getUser({required String user}) async {
    final response =
        await client.get(Uri.parse("https://api.github.com/users/$user"));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return UserModel.fromJson(data);
    } else {
      if (response.body.contains('message')) {
        throw HttpException(jsonDecode(response.body)['message']);
      }
      throw HttpException(response.body);
    }
  }
}
