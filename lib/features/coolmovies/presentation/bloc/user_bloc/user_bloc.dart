import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coolmovies/features/coolmovies/data/models/user/user_model.dart';
import 'package:coolmovies/features/coolmovies/data/repository/repository.dart';
import 'package:coolmovies/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_login/flutter_login.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserNotAuthenticated()) {
    on<LogInUserEvent>(_onLogInUser);
    on<SignUpUserEvent>(_onSignUpUser);
    on<LogOutUserEvent>(_onLogOutUser);
    on<LogInCurrentUserEvent>(_onLogInCurrentUserEvent);
  }

  Future<FutureOr<void>> _onLogInUser(
      LogInUserEvent event, Emitter<UserState> emit) async {
    try {
      // This would be used if there were a login on DB
      if (kDebugMode) {
        print(event.loginData);
      }
      final User user = await sl<Repository>().fetchCurrentUser();
      emit(UserAuthenticated(user: user));
    } catch (e) {
      emit(UserNotAuthenticated(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onSignUpUser(
      SignUpUserEvent event, Emitter<UserState> emit) async {
    try {
      final User user =
          await sl<Repository>().signUpUser(signupData: event.signupData);
      emit(UserAuthenticated(user: user));
    } catch (e) {
      emit(UserNotAuthenticated(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _onLogOutUser(
      LogOutUserEvent event, Emitter<UserState> emit) async {
    emit(UserNotAuthenticated());
  }

  Future<FutureOr<void>> _onLogInCurrentUserEvent(
      LogInCurrentUserEvent event, Emitter<UserState> emit) async {
    try {
      final User user = await sl<Repository>().fetchCurrentUser();
      emit(UserAuthenticated(user: user));
    } catch (e) {
      emit(UserNotAuthenticated(error: e.toString()));
    }
  }
}
