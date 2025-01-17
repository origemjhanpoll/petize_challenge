import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/i_repository.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';

class UserCubit extends Cubit<UserState> {
  final IUserRepository _repository;

  UserCubit({required IUserRepository repository})
      : _repository = repository,
        super(UserInitial());

  final _log = Logger('UserCubit');

  Future<void> load({required String user}) async {
    emit(UserLoading());
    try {
      final userResult = await _repository.getUser(user: user);
      emit(UserSuccess(userResult));
      _log.fine('Loaded user');
    } on HttpException catch (error) {
      emit(UserError(error.message));
      _log.warning('Failed to load user', error);
    } catch (e) {
      emit(UserError('An unexpected error occurred.'));
      _log.severe('An error occurred while loading data', e);
    }
  }
}
