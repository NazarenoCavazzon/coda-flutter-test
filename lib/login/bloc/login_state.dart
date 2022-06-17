part of 'login_bloc.dart';

enum LoginStateStatus {
  initial,
  attemptingLogin,
  succesful,
  failure,
}

class LoginState extends Equatable {
  const LoginState({
    this.error,
    this.status = LoginStateStatus.initial,
  });

  final Exception? error;
  final LoginStateStatus status;

  LoginState copyWith({
    Exception? error,
    LoginStateStatus? status,
  }) {
    return LoginState(
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  bool get isInitial => status == LoginStateStatus.initial;
  bool get isAttempting => status == LoginStateStatus.attemptingLogin;
  bool get isSuccesful => status == LoginStateStatus.succesful;
  bool get isFailure => status == LoginStateStatus.failure;

  @override
  List<Object?> get props => [error ?? Object(), status];
}
