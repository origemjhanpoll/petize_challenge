import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';

class RepoCubit extends Cubit<RepoState> {
  final IUserRepository _repository;

  RepoCubit({required IUserRepository repository})
      : _repository = repository,
        super(RepoInitial());

  final _log = Logger('RepoCubit');

  Future<void> load({required String url}) async {
    emit(RepoLoading());
    try {
      final reposResult = await _repository.getRepos(url: url);
      emit(RepoSuccess(reposResult));
      _log.fine('Loaded repos');
    } on HttpException catch (error) {
      emit(RepoError(error.message));
      _log.warning('Failed to load repos', error);
    } catch (e) {
      emit(RepoError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
    }
  }
}
