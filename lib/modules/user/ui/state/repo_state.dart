import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';

class RepoState extends Equatable {
  final List<RepoModel> repos;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final String? errorMessage;

  const RepoState({
    required this.repos,
    this.isLoaded = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  factory RepoState.init() {
    return RepoState(
      repos: [],
      isLoading: false,
      isLoaded: false,
      hasError: false,
      errorMessage: null,
    );
  }

  RepoState copyWith({
    List<RepoModel>? repos,
    bool? isLoading,
    bool? isLoaded,
    bool? hasError,
    String? errorMessage,
  }) {
    return RepoState(
      repos: repos ?? this.repos,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        repos,
        isLoaded,
        isLoading,
        hasError,
        errorMessage,
      ];
}
