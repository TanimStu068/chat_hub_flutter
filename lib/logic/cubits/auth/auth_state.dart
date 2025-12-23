import 'package:chat_hub/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  signupSuccess,
  unauthenticated,
  error,
  passwordResetEmailSent,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel? user;
  final String? error;
  const AuthState({this.status = AuthStatus.initial, this.user, this.error});

  AuthState copyWith({AuthStatus? status, UserModel? user, String? error}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
