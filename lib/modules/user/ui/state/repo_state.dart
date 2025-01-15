import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';

abstract class RepoState extends Equatable {
  const RepoState();

  @override
  List<Object?> get props => [];
}

class RepoInitial extends RepoState {}

class RepoLoading extends RepoState {}

class RepoLoadingMore extends RepoState {}

class RepoEmpty extends RepoState {}

class RepoSuccess extends RepoState {
  final String url;
  final List<RepoModel> repos;
  const RepoSuccess({required this.url, required this.repos});

  @override
  List<Object?> get props => [url, repos];
}

class RepoError extends RepoState {
  final String errorMessage;
  const RepoError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
