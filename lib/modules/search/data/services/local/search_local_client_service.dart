import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchLocalClientService {
  final _log = Logger('SearchLocalClientDataService');

  Future<void> saveRecentUser({required UserItem user}) async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final recentUsersJson =
          sharedPreferences.getString('recent_users') ?? '[]';
      final recentUsers = (jsonDecode(recentUsersJson) as List)
          .map((json) => UserItem.fromJson(json as Map<String, dynamic>))
          .toList();

      recentUsers.removeWhere((u) => u.id == user.id);
      recentUsers.insert(0, user);

      if (recentUsers.length > 10) {
        recentUsers.removeLast();
      }

      await sharedPreferences.setString(
        'recent_users',
        jsonEncode(recentUsers.map((u) => u.toJson()).toList()),
      );

      _log.finer('Saved recent user: ${user.login}');
    } catch (e) {
      _log.warning('Failed to save recent user', e);
      throw Exception('Failed to save recent user: $e');
    }
  }

  Future<List<UserItem>> loadRecentUsers() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      final recentUsersJson = sharedPreferences.getString('recent_users');
      if (recentUsersJson == null) {
        return [];
      }
      return (jsonDecode(recentUsersJson) as List)
          .map((json) => UserItem.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _log.warning('Failed to load recent users', e);
      throw Exception('Failed to load recent users: $e');
    }
  }
}
