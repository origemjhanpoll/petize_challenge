import 'package:equatable/equatable.dart';

class SearchUsersModel extends Equatable {
  final int totalCount;
  final bool incompleteResults;
  final List<UserItem> items;

  const SearchUsersModel({
    required this.totalCount,
    required this.incompleteResults,
    required this.items,
  });

  factory SearchUsersModel.fromJson(Map<String, dynamic> json) {
    return SearchUsersModel(
      totalCount: json['total_count'] as int,
      incompleteResults: json['incomplete_results'] as bool,
      items: (json['items'] as List)
          .map((item) => UserItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  SearchUsersModel copyWith({
    int? totalCount,
    bool? incompleteResults,
    List<UserItem>? items,
  }) {
    return SearchUsersModel(
      totalCount: totalCount ?? this.totalCount,
      incompleteResults: incompleteResults ?? this.incompleteResults,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [totalCount, incompleteResults, items];
}

class UserItem extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;

  const UserItem({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      login: json['login'] as String,
      id: json['id'] as int,
      avatarUrl: json['avatar_url'] as String,
      htmlUrl: json['html_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }

  UserItem copyWith({
    String? login,
    int? id,
    String? avatarUrl,
    String? htmlUrl,
  }) {
    return UserItem(
      login: login ?? this.login,
      id: id ?? this.id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      htmlUrl: htmlUrl ?? this.htmlUrl,
    );
  }

  @override
  List<Object?> get props => [login, id, avatarUrl, htmlUrl];
}
