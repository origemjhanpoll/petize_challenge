import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';

class RepoCubit extends Cubit<RepoState> {
  final Repository _repository;

  RepoCubit({required Repository repository})
      : _repository = repository,
        super(RepoInitial());

  final _log = Logger('RepoCubit');

  Future<void> load({required String url}) async {
    emit(RepoLoading());
    try {
      final reposResult = await _repository.getRepos(url: url);
      if (!isClosed) {
        emit(RepoSuccess(reposResult));
        _log.fine('Loaded repos');
      }
    } on HttpException catch (error) {
      if (!isClosed) {
        emit(RepoError(error.message));
        _log.warning('Failed to load repos', error);
      }
    } catch (e) {
      if (!isClosed) {
        emit(RepoError('An unexpected error occurred.'));
        _log.severe('An error occurred while loading data', e);
      }
    }
  }
}
