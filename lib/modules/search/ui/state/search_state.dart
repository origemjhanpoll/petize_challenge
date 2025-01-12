import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';

class SearchState extends Equatable {
  final SearchUsersModel search;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final String? errorMessage;

  const SearchState({
    required this.search,
    this.isLoaded = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  factory SearchState.init() {
    return SearchState(
      search: SearchUsersModel(
        incompleteResults: false,
        totalCount: 0,
        items: [],
      ),
      isLoading: false,
      isLoaded: false,
      hasError: false,
      errorMessage: null,
    );
  }

  SearchState copyWith({
    SearchUsersModel? search,
    bool? isLoading,
    bool? isLoaded,
    bool? hasError,
    String? errorMessage,
  }) {
    return SearchState(
      search: search ?? this.search,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        search,
        isLoaded,
        isLoading,
        hasError,
        errorMessage,
      ];
}
