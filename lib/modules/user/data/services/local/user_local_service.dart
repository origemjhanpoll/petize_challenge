import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalService {
  final _log = Logger('LocalDataService');

  Future<void> saveUser(UserModel? user) async {
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
    } catch (e) {
      _log.warning('Failed to save user', e);
      Exception('Failed to save user: $e ');
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
    } catch (e) {
      _log.warning('Failed to load user', e);
      Exception('Failed to load user: $e ');
      return null;
    }
  }

  Future<void> saveRepos(List<RepoModel>? repos) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (repos == null) {
        _log.finer('Removed repos');
        await sharedPreferences.remove('repos');
      } else {
        _log.finer('Saved repos');
        final reposJson = repos.map((json) => jsonEncode(json)).toList();
        await sharedPreferences.setStringList('repos', reposJson);
      }
    } catch (e) {
      _log.warning('Failed to save repos', e);
      Exception('Failed to save repos: $e ');
    }
  }

  Future<List<RepoModel>?> loadRepos() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final reposJson = sharedPreferences.getStringList('repos');
      if (reposJson == null) {
        return null;
      }
      return reposJson
          .map((json) => RepoModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      _log.warning('Failed to load repos', e);
      Exception('Failed to load repos: $e ');
      return null;
    }
  }
}
