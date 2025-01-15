import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/search/domain/models/search_users_model.dart';
import 'package:petize_challenge/modules/search/ui/state/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final ISearchRepository _repository;

  SearchCubit({required ISearchRepository repository})
      : _repository = repository,
        super(SearchInitial());

  final _log = Logger('SearchCubit');

  final List<UserItem> _loadedItems = [];
  bool _hasMore = true;
  bool _isLoading = false;
  int _currentPage = 1;

  String? _currentSearchTerm;

  Future<void> load(
      {String? user, int page = 1, bool isNewSearch = false}) async {
    if (_isLoading) return;

    if (isNewSearch) {
      if (user == null || user.isEmpty) {
        emit(SearchError('Search term is required for a new search.'));
        return;
      }

      _currentSearchTerm = user;
      _loadedItems.clear();
      _currentPage = 1;
      _hasMore = true;

      emit(SearchLoading());
    } else {
      emit(SearchLoadingMore());
    }

    if (!_hasMore || _currentSearchTerm == null) return;

    _isLoading = true;

    try {
      final searchResult = await _repository.getUsers(
        user: _currentSearchTerm!,
        page: _currentPage,
      );

      if (searchResult.items.isEmpty) {
        _hasMore = false;

        if (_loadedItems.isEmpty) {
          emit(SearchEmpty());
        }
      } else {
        _loadedItems.addAll(searchResult.items);
        _currentPage++;

        emit(SearchSuccess(searchResult.copyWith(items: _loadedItems)));
      }

      _log.fine('Loaded search results');
    } on HttpException catch (error) {
      emit(SearchError(error.message));
      _log.warning('Failed to load users', error);
    } catch (e) {
      emit(SearchError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> saveRecentUser({required UserItem user}) async {
    try {
      await _repository.saveRecentUser(user: user);
      await loadRecentUsers();
      _log.fine('Save recent user result');
    } catch (e) {
      _log.severe('An error occurred while saved data', e);
    }
  }

  Future<void> loadRecentUsers() async {
    try {
      final recentUsersResult = await _repository.loadRecentUsers();

      if (recentUsersResult != null && recentUsersResult.isNotEmpty) {
        emit(SearchRecentUses(recentUsersResult));
      } else {
        emit(SearchRecentEmpty());
      }
      _log.fine('Loaded recents users results');
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
    }
  }

  Future<void> clearRecentUsers() async {
    try {
      await _repository.clearRecentUsers();
      emit(SearchRecentEmpty());
      _log.fine('Clean recent user result');
    } catch (e) {
      _log.severe('An error occurred while clean data', e);
    }
  }
}
