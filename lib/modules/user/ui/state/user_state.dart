import 'package:equatable/equatable.dart';
import 'package:petize_challenge/modules/user/domain/models/user_model.dart';

class UserState extends Equatable {
  final UserModel user;
  final List repos;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final String? errorMessage;

  const UserState({
    required this.user,
    required this.repos,
    this.isLoaded = false,
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  factory UserState.init() {
    return UserState(
      user: UserModel.init(),
      repos: [],
      isLoading: false,
      isLoaded: false,
      hasError: false,
      errorMessage: null,
    );
  }

  UserState copyWith({
    UserModel? user,
    List? repos,
    bool? isLoading,
    bool? isLoaded,
    bool? hasError,
    String? errorMessage,
  }) {
    return UserState(
      user: user ?? this.user,
      repos: repos ?? this.repos,
      isLoaded: isLoaded ?? this.isLoaded,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        user,
        repos,
        isLoaded,
        isLoading,
        hasError,
        errorMessage,
      ];
}
