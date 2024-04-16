part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserAuthenticated extends UserState {
  final User user;
  UserAuthenticated({required this.user});
}

final class UserNotAuthenticated extends UserState {
  final String? error;
  UserNotAuthenticated({this.error});
}
