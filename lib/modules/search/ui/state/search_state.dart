import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoadingMore extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchRecentEmpty extends SearchState {}

class SearchSuccess extends SearchState {
  final SearchUsersModel search;
  const SearchSuccess(this.search);

  @override
  List<Object?> get props => [search];
}

class SearchRecentUses extends SearchState {
  final List<UserItem> recentUsers;
  const SearchRecentUses(this.recentUsers);

  @override
  List<Object?> get props => [recentUsers];
}

class SearchError extends SearchState {
  final String errorMessage;
  const SearchError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
