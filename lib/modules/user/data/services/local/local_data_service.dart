import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/utils/result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataService {
  final _log = Logger('LocalDataService');

  UserModel getUser() {
    return UserModel.init();
  }

  Future<Result<void>> saveUser(UserModel? user) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (user == null) {
        _log.finer('Removed user');
        await sharedPreferences.remove('user');
      } else {
        _log.finer('Saved user');
        final userJson = jsonEncode(user.toJson());
        await sharedPreferences.setString('user', userJson);
      }
      return const Result.ok(null);
    } on Exception catch (e) {
      _log.warning('Failed to save user', e);
      return Result.error(e);
    }
  }

  Future<UserModel?> loadUser() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final userJson = sharedPreferences.getString('user');
      if (userJson == null) {
        return null;
      }
      return UserModel.fromJson(jsonDecode(userJson));
    } on Exception catch (e) {
      _log.warning('Failed to load user', e);
      return null;
    }
  }
}
