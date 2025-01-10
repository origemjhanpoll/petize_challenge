import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String login;
  final int id;
  final String avatarUrl;
  final String url;
  final String reposUrl;

  const UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.url,
    required this.reposUrl,
  });

  static UserModel init() {
    return const UserModel(
      login: '',
      id: 0,
      avatarUrl: '',
      url: '',
      reposUrl: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      reposUrl: json['repos_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'url': url,
      'repos_url': reposUrl,
    };
  }

  UserModel copyWith({
    String? login,
    int? id,
    String? avatarUrl,
    String? url,
    String? reposUrl,
  }) {
    return UserModel(
      login: login ?? this.login,
      id: id ?? this.id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      url: url ?? this.url,
      reposUrl: reposUrl ?? this.reposUrl,
    );
  }

  @override
  List<Object?> get props => [
        login,
        id,
        avatarUrl,
        url,
        reposUrl,
      ];
}
