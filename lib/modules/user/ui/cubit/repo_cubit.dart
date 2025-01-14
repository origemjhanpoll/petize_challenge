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

  Future<void> load({
    required String url,
    String? sort,
    String? direction,
    int? perPage,
    int? page,
  }) async {
    emit(RepoLoading());
    try {
      final reposResult = await _repository.getRepos(
        url: url,
        sort: sort,
        direction: direction,
        perPage: perPage,
        page: page,
      );
      if (reposResult.isNotEmpty) {
        emit(RepoSuccess(url: url, repos: reposResult));
      } else {
        emit(RepoEmpty());
      }
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
