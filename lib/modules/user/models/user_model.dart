import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String gravatarId;
  final String url;
  final String htmlUrl;
  final String followersUrl;
  final String followingUrl;
  final String gistsUrl;
  final String starredUrl;
  final String subscriptionsUrl;
  final String organizationsUrl;
  final String reposUrl;
  final String eventsUrl;
  final String receivedEventsUrl;
  final String type;
  final String userViewType;
  final bool siteAdmin;
  final String? name;
  final String? company;
  final String? blog;
  final String? location;
  final String? email;
  final bool? hireable;
  final String? bio;
  final String? twitterUsername;
  final int publicRepos;
  final int publicGists;
  final int followers;
  final int following;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.gravatarId,
    required this.url,
    required this.htmlUrl,
    required this.followersUrl,
    required this.followingUrl,
    required this.gistsUrl,
    required this.starredUrl,
    required this.subscriptionsUrl,
    required this.organizationsUrl,
    required this.reposUrl,
    required this.eventsUrl,
    required this.receivedEventsUrl,
    required this.type,
    required this.userViewType,
    required this.siteAdmin,
    this.name,
    this.company,
    this.blog,
    this.location,
    this.email,
    this.hireable,
    this.bio,
    this.twitterUsername,
    required this.publicRepos,
    required this.publicGists,
    required this.followers,
    required this.following,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.init() {
    return UserModel(
      login: "",
      id: 0,
      nodeId: "",
      avatarUrl: "",
      gravatarId: "",
      url: "",
      htmlUrl: "",
      followersUrl: "",
      followingUrl: "",
      gistsUrl: "",
      starredUrl: "",
      subscriptionsUrl: "",
      organizationsUrl: "",
      reposUrl: "",
      eventsUrl: "",
      receivedEventsUrl: "",
      type: "",
      userViewType: "",
      siteAdmin: false,
      publicRepos: 0,
      publicGists: 0,
      followers: 0,
      following: 0,
      createdAt: null,
      updatedAt: null,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      gravatarId: json['gravatar_id'],
      url: json['url'],
      htmlUrl: json['html_url'],
      followersUrl: json['followers_url'],
      followingUrl: json['following_url'],
      gistsUrl: json['gists_url'],
      starredUrl: json['starred_url'],
      subscriptionsUrl: json['subscriptions_url'],
      organizationsUrl: json['organizations_url'],
      reposUrl: json['repos_url'],
      eventsUrl: json['events_url'],
      receivedEventsUrl: json['received_events_url'],
      type: json['type'],
      userViewType: json['user_view_type'],
      siteAdmin: json['site_admin'],
      name: json['name'],
      company: json['company'],
      blog: json['blog'],
      location: json['location'],
      email: json['email'],
      hireable: json['hireable'],
      bio: json['bio'],
      twitterUsername: json['twitter_username'],
      publicRepos: json['public_repos'],
      publicGists: json['public_gists'],
      followers: json['followers'],
      following: json['following'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  @override
  List<Object?> get props => [
        login,
        id,
        nodeId,
        avatarUrl,
        gravatarId,
        url,
        htmlUrl,
        followersUrl,
        followingUrl,
        gistsUrl,
        starredUrl,
        subscriptionsUrl,
        organizationsUrl,
        reposUrl,
        eventsUrl,
        receivedEventsUrl,
        type,
        userViewType,
        siteAdmin,
        name,
        company,
        blog,
        location,
        email,
        hireable,
        bio,
        twitterUsername,
        publicRepos,
        publicGists,
        followers,
        following,
        createdAt,
        updatedAt,
      ];
}
