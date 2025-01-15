import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/user/domain/models/repo_model.dart';
import 'package:petize_challenge/modules/user/ui/state/repo_state.dart';

class RepoCubit extends Cubit<RepoState> {
  final IUserRepository _repository;

  RepoCubit({required IUserRepository repository})
      : _repository = repository,
        super(RepoInitial());

  final _log = Logger('RepoCubit');

  final List<RepoModel> _loadedItems = [];
  bool _hasMore = true;
  bool _isLoading = false;
  int _currentPage = 1;
  String? _currentUrl;

  Future<void> load({
    String? url,
    String? sort,
    String? direction,
    int? perPage,
    int? page,
    bool isNewSearch = false,
  }) async {
    if (_isLoading) return;

    if (isNewSearch) {
      if (url == null || url.isEmpty) {
        emit(RepoError('Repor term is required for a new search.'));
        return;
      }

      _currentUrl = url;
      _loadedItems.clear();
      _currentPage = 1;
      _hasMore = true;

      emit(RepoLoading());
    } else {
      emit(RepoLoadingMore());
    }

    if (!_hasMore || _currentUrl == null) return;
    _isLoading = true;

    try {
      final reposResult = await _repository.getRepos(
        url: _currentUrl!,
        sort: sort,
        direction: direction,
        perPage: perPage,
        page: _currentPage,
      );
      if (reposResult.isEmpty) {
        _hasMore = false;

        if (_loadedItems.isEmpty) {
          emit(RepoEmpty());
        }
      } else {
        _loadedItems.addAll(reposResult);
        _currentPage++;
        emit(RepoSuccess(url: _currentUrl!, repos: _loadedItems));
      }
      _log.fine('Loaded repos');
    } on HttpException catch (error) {
      emit(RepoError(error.message));
      _log.warning('Failed to load repos', error);
    } catch (e) {
      emit(RepoError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
    } finally {
      _isLoading = false;
    }
  }
}
