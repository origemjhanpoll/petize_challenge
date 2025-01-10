import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:petize_challenge/modules/user/data/repositories/user_repository.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';
import 'package:petize_challenge/modules/user/ui/state/user_state.dart';
import 'package:petize_challenge/utils/result.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _repository;

  UserCubit({required UserRepository repository})
      : _repository = repository,
        super(UserState.init());

  final _log = Logger('UserViewModel');

  Future<void> loadUser({required String user}) async {
    emit(state.copyWith(isLoading: true));
    try {
      final userResult = await _repository.getUser(user: user);
      if (userResult is Ok<UserModel>) {
        emit(state.copyWith(isLoaded: true, user: userResult.value));
        _log.fine('Loaded user');
      } else if (userResult is Error<UserModel>) {
        emit(state.copyWith(
            hasError: true, errorMessage: 'Failed to load user'));
        _log.warning('Failed to load user', userResult.error);
      }
    } catch (e) {
      _log.severe('An error occurred while loading data', e);
      emit(state.copyWith(
          hasError: true, errorMessage: 'An unexpected error occurred.'));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
