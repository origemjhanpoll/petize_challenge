import 'package:equatable/equatable.dart';

class RepoInfoModel extends Equatable {
  final String url;
  final int length;
  final int maximumLength;

  const RepoInfoModel({
    this.url = '',
    this.length = 0,
    this.maximumLength = 0,
  });

  // Método copyWith para criar uma nova instância com alterações específicas
  RepoInfoModel copyWith({
    String? url,
    int? length,
    int? maximumLength,
  }) {
    return RepoInfoModel(
      url: url ?? this.url,
      length: length ?? this.length,
      maximumLength: maximumLength ?? this.maximumLength,
    );
  }

  @override
  List<Object?> get props => [url, length, maximumLength];
}
