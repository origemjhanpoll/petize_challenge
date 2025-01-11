import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/repository.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final Repository _repository;

  UserCubit({required Repository repository})
      : _repository = repository,
        super(UserState.init());

  final _log = Logger('UserCubit');

  Future<void> load({required String user}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userResult = await _repository.getUser(user: user);
      emit(state.copyWith(isLoaded: true, user: userResult));
      _log.fine('Loaded user');
    } on HttpException catch (error) {
      emit(state.copyWith(hasError: true, errorMessage: error.message));
      _log.warning('Failed to load user', error);
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
      emit(state.copyWith(
          hasError: true, errorMessage: 'An unexpected error occurred.'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
