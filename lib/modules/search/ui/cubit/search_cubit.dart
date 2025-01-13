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

  Future<void> load({required String user}) async {
    emit(SearchLoading());
    try {
      final searchResult = await _repository.getUsers(user: user, page: 1);

      if (searchResult.items.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(searchResult));
      }
      _log.fine('Loaded search results');
    } on HttpException catch (error) {
      emit(SearchError(error.message));
      _log.warning('Failed to load users', error);
    } catch (e) {
      emit(SearchError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
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
        emit(SearchInitial());
      }
      _log.fine('Loaded recents users results');
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
    }
  }

  Future<void> clearRecentUsers() async {
    try {
      await _repository.clearRecentUsers();
      emit(SearchInitial());
      _log.fine('Clean recent user result');
    } catch (e) {
      _log.severe('An error occurred while clean data', e);
    }
  }
}
