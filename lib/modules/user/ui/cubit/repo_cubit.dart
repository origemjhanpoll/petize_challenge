import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';

class RepoCubit extends Cubit<RepoState> {
  final Repository _repository;

  RepoCubit({required Repository repository})
      : _repository = repository,
        super(RepoState.init());

  final _log = Logger('RepoCubit');

  Future<void> load({required String url}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final reposResult = await _repository.getRepos(url: url);
      emit(state.copyWith(isLoaded: true, repos: reposResult));
      _log.fine('Loaded repos');
    } on HttpException catch (error) {
      emit(state.copyWith(hasError: true, errorMessage: error.message));
      _log.warning('Failed to load repos', error);
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
      emit(state.copyWith(
          hasError: true, errorMessage: 'An unexpected error occurred.'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
