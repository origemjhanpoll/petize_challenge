import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/search/data/repositories/repository.dart';
import 'package:petize_challenge/modules/search/ui/state/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;

  SearchCubit({required SearchRepository repository})
      : _repository = repository,
        super(SearchInitial());

  final _log = Logger('SearchCubit');

  Future<void> load({required String user}) async {
    emit(SearchLoading());
    try {
      final searchResult = await _repository.getUsers(user: user, page: 1);
      emit(SearchSuccess(searchResult));
      _log.fine('Loaded search results');
    } on HttpException catch (error) {
      emit(SearchError(error.message));
      _log.warning('Failed to load users', error);
    } catch (e) {
      emit(SearchError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
    }
  }

  Future<void> clean() async {
    emit(SearchInitial());
    _log.fine('Initial search result');
  }
}
