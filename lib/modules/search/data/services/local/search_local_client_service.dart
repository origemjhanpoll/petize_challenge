import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLocalClientService {
  final _log = Logger('SearchLocalClientDataService');

  Future<void> saveRecentUsers(List<UserItem>? repos) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (repos == null) {
        _log.finer('Removed recent users');
        await sharedPreferences.remove('recent_users');
      } else {
        _log.finer('Saved recent users');
        final recentUsersJson = repos.map((json) => jsonEncode(json)).toList();
        await sharedPreferences.setStringList('recent_users', recentUsersJson);
      }
    } catch (e) {
      _log.warning('Failed to save recent users', e);
      Exception('Failed to save recent users: $e ');
    }
  }

  Future<List<UserItem>?> loadRecentUsers() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final recentUsersJson = sharedPreferences.getStringList('recent_users');
      if (recentUsersJson == null) {
        return null;
      }
      return recentUsersJson
          .map((json) => UserItem.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      _log.warning('Failed to load recent users', e);
      Exception('Failed to load recent users: $e ');
      return null;
    }
  }
}
