import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/data/repositories/repository.dart';
import 'package:petize_challenge/modules/search/ui/state/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;

  SearchCubit({required SearchRepository repository})
      : _repository = repository,
        super(SearchState.init());

  final _log = Logger('SearchCubit');

  Future<void> load({required String user}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final searchResult = await _repository.getUsers(user: user, page: 1);
      emit(state.copyWith(isLoaded: true, search: searchResult));
      _log.fine('Loaded user');
    } on HttpException catch (error) {
      emit(state.copyWith(hasError: true, errorMessage: error.message));
      _log.warning('Failed to load users', error);
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
      emit(state.copyWith(
          hasError: true, errorMessage: 'An unexpected error occurred.'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
