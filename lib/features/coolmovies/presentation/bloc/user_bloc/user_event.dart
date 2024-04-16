part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class LogInUserEvent extends UserEvent {
  final LoginData loginData;
  LogInUserEvent({required this.loginData});

  get movieId => null;
}

class SignUpUserEvent extends UserEvent {
  final SignupData signupData;
  SignUpUserEvent({required this.signupData});
}

class LogOutUserEvent extends UserEvent {}

class LogInCurrentUserEvent extends UserEvent {}
