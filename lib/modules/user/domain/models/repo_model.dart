import 'package:equatable/equatable.dart';

class RepoModel extends Equatable {
  final String name;
  final String? description;
  final int stargazersCount;
  final String updatedAt;

  const RepoModel({
    required this.name,
    required this.updatedAt,
    this.description,
    this.stargazersCount = 0,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      name: json['name'] as String,
      description: json['description'] as String?,
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      updatedAt: json['updated_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'stargazers_count': stargazersCount,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        name,
        description,
        stargazersCount,
        updatedAt,
      ];
}
