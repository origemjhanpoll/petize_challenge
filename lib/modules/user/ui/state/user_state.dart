import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';

class UserState extends Equatable {
  final UserModel user;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final String? errorMessage;

  const UserState({
    required this.user,
    this.isLoaded = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  factory UserState.init() {
    return UserState(
      user: UserModel.init(),
      isLoading: false,
      isLoaded: false,
      hasError: false,
      errorMessage: null,
    );
  }

  UserState copyWith({
    UserModel? user,
    bool? isLoading,
    bool? isLoaded,
    bool? hasError,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        user,
        isLoaded,
        isLoading,
        hasError,
        errorMessage,
      ];
}
