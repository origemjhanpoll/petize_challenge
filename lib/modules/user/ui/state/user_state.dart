import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final UserModel user;
  const UserSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String errorMessage;
  const UserError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
