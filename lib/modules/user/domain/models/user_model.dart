import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String login;
  final int id;
  final String avatarUrl;
  final String reposUrl;
  final String? blog;
  final int followers;
  final int following;
  final String? bio;
  final String? company;
  final String? location;
  final String? email;
  final String? twitterUsername;

  const UserModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.reposUrl,
    required this.name,
    this.blog,
    this.followers = 0,
    this.following = 0,
    this.bio,
    this.company,
    this.location,
    this.email,
    this.twitterUsername,
  });

  static UserModel init() {
    return const UserModel(
      name: '',
      login: '',
      id: 0,
      avatarUrl: '',
      blog: '',
      reposUrl: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      login: json['login'],
      id: json['id'],
      avatarUrl: json['avatar_url'],
      reposUrl: json['repos_url'],
      blog: json['blog'],
      followers: json['followers'],
      following: json['following'],
      bio: json['bio'],
      company: json['company'],
      location: json['location'],
      email: json['email'],
      twitterUsername: json['twitter_username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'repos_url': reposUrl,
      'blog': blog,
      'followers': followers,
      'following': following,
      'bio': bio,
      'company': company,
      'location': location,
      'email': email,
      'twitter_username': twitterUsername,
    };
  }

  UserModel copyWith({
    String? name,
    String? login,
    int? id,
    String? avatarUrl,
    String? reposUrl,
    String? blog,
    int? followers,
    int? following,
    String? bio,
    String? company,
    String? location,
    String? email,
    String? twitterUsername,
  }) {
    return UserModel(
      name: name ?? this.name,
      login: login ?? this.login,
      id: id ?? this.id,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      reposUrl: reposUrl ?? this.reposUrl,
      blog: blog ?? this.blog,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      bio: bio ?? this.bio,
      company: company ?? this.company,
      location: location ?? this.location,
      email: email ?? this.email,
      twitterUsername: twitterUsername ?? this.twitterUsername,
    );
  }

  @override
  List<Object?> get props => [
        name,
        login,
        id,
        avatarUrl,
        reposUrl,
        blog,
        followers,
        following,
        bio,
        company,
        location,
        email,
        twitterUsername,
      ];
}
