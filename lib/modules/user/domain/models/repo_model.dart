import 'package:equatable/equatable.dart';

class RepoModel extends Equatable {
  final String name;
  final String? description;
  final int stargazersCount;
  final String htmlUrl;
  final String updatedAt;

  const RepoModel({
    required this.name,
    required this.updatedAt,
    required this.htmlUrl,
    this.description,
    this.stargazersCount = 0,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      htmlUrl: json['html_url'] as String,
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'html_url': htmlUrl,
      'stargazers_count': stargazersCount,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        name,
        description,
        htmlUrl,
        stargazersCount,
        updatedAt,
      ];
}
