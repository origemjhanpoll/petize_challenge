import 'package:equatable/equatable.dart';

class RepoApiModel extends Equatable {
  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final bool private;
  final Owner owner;
  final String htmlUrl;
  final String? description;
  final bool fork;
  final String url;
  final String createdAt;
  final String updatedAt;
  final String pushedAt;
  final String gitUrl;
  final String sshUrl;
  final String cloneUrl;
  final String svnUrl;
  final String? homepage;
  final int size;
  final int stargazersCount;
  final int watchersCount;
  final String? language;
  final bool hasIssues;
  final bool hasProjects;
  final bool hasDownloads;
  final bool hasWiki;
  final bool hasPages;
  final bool hasDiscussions;
  final int forksCount;
  final bool archived;
  final bool disabled;
  final int openIssuesCount;
  final License? license;
  final bool allowForking;
  final bool isTemplate;
  final bool webCommitSignoffRequired;
  final List<String> topics;
  final String visibility;
  final int forks;
  final int openIssues;
  final int watchers;
  final String defaultBranch;

  const RepoApiModel({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.private,
    required this.owner,
    required this.htmlUrl,
    this.description,
    required this.fork,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.pushedAt,
    required this.gitUrl,
    required this.sshUrl,
    required this.cloneUrl,
    required this.svnUrl,
    this.homepage,
    required this.size,
    required this.stargazersCount,
    required this.watchersCount,
    this.language,
    required this.hasIssues,
    required this.hasProjects,
    required this.hasDownloads,
    required this.hasWiki,
    required this.hasPages,
    required this.hasDiscussions,
    required this.forksCount,
    required this.archived,
    required this.disabled,
    required this.openIssuesCount,
    this.license,
    required this.allowForking,
    required this.isTemplate,
    required this.webCommitSignoffRequired,
    required this.topics,
    required this.visibility,
    required this.forks,
    required this.openIssues,
    required this.watchers,
    required this.defaultBranch,
  });

  factory RepoApiModel.fromJson(Map<String, dynamic> json) {
    return RepoApiModel(
      id: json['id'],
      nodeId: json['node_id'],
      name: json['name'],
      fullName: json['full_name'],
      private: json['private'],
      owner: Owner.fromJson(json['owner']),
      htmlUrl: json['html_url'],
      description: json['description'],
      fork: json['fork'],
      url: json['url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pushedAt: json['pushed_at'],
      gitUrl: json['git_url'],
      sshUrl: json['ssh_url'],
      cloneUrl: json['clone_url'],
      svnUrl: json['svn_url'],
      homepage: json['homepage'],
      size: json['size'],
      stargazersCount: json['stargazers_count'],
      watchersCount: json['watchers_count'],
      language: json['language'],
      hasIssues: json['has_issues'],
      hasProjects: json['has_projects'],
      hasDownloads: json['has_downloads'],
      hasWiki: json['has_wiki'],
      hasPages: json['has_pages'],
      hasDiscussions: json['has_discussions'],
      forksCount: json['forks_count'],
      archived: json['archived'],
      disabled: json['disabled'],
      openIssuesCount: json['open_issues_count'],
      license:
          json['license'] != null ? License.fromJson(json['license']) : null,
      allowForking: json['allow_forking'],
      isTemplate: json['is_template'],
      webCommitSignoffRequired: json['web_commit_signoff_required'],
      topics: List<String>.from(json['topics']),
      visibility: json['visibility'],
      forks: json['forks'],
      openIssues: json['open_issues'],
      watchers: json['watchers'],
      defaultBranch: json['default_branch'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        nodeId,
        name,
        fullName,
        private,
        owner,
        htmlUrl,
        description,
        fork,
        url,
        createdAt,
        updatedAt,
        pushedAt,
        gitUrl,
        sshUrl,
        cloneUrl,
        svnUrl,
        homepage,
        size,
        stargazersCount,
        watchersCount,
        language,
        hasIssues,
        hasProjects,
        hasDownloads,
        hasWiki,
        hasPages,
        hasDiscussions,
        forksCount,
        archived,
        disabled,
        openIssuesCount,
        license,
        allowForking,
        isTemplate,
        webCommitSignoffRequired,
        topics,
        visibility,
        forks,
        openIssues,
        watchers,
        defaultBranch,
      ];
}

class Owner extends Equatable {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String url;
  final String htmlUrl;

  const Owner({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
    required this.htmlUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
      htmlUrl: json['html_url'],
    );
  }

  @override
  List<Object?> get props => [login, id, nodeId, avatarUrl, url, htmlUrl];
}

class License extends Equatable {
  final String key;
  final String name;
  final String spdxId;
  final String? url;

  const License({
    required this.key,
    required this.name,
    required this.spdxId,
    this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      key: json['key'],
      name: json['name'],
      spdxId: json['spdx_id'],
      url: json['url'],
    );
  }

  @override
  List<Object?> get props => [key, name, spdxId, url];
}
