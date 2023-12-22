import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_sources/repository/user_repository.dart';
import 'user_state.dart';
import 'user_event.dart';
import 'user_bloc.dart';

export 'user_state.dart';
export 'user_event.dart';
export 'user_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserBlocState> {
  final UserRepository _userRepository;
  final SharedPreferences _sharedPreferences;

  static create(UserRepository userRepository, SharedPreferences sharedPreferences) => UserBloc(userRepository, sharedPreferences);

  UserBloc(this._userRepository, this._sharedPreferences) : super(LoadingUserState()) {
    on<GetUserEvent>(_getUserEvent);
    on<LogoutEvent>(_logoutToState);
    on<ChangeNameEvent>(_changeNameToState);
    on<ChangePasswordEvent>(_changePasswordToState);
  }

  _getUserEvent(GetUserEvent e, Emitter<UserBlocState> emit) async {
    emit(LoadingUserState());
    final token = _sharedPreferences.getString("access_token");
    try{
      final response = await _userRepository.getUser("Bearer $token");
      if (response.message == "ok") {
        emit(GetUserState(response.result, response.check));
      }
    } on DioException catch(e) {
      if(e.response?.statusCode == 500) {
        emit(NotLoggedInState());
      }
      else {
        emit(FailedUserState());
      }
    }
  }

  _logoutToState(LogoutEvent e, Emitter<UserBlocState> emit) async {
    emit(LoadingUserState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _userRepository.logout("Bearer $token");
      if(response.message == "you've been logged out") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove("access_token");
        emit(NotLoggedInState());
      }
    } on DioException catch(e) {
      if(e.response?.statusCode == 400){
        emit(NotLoggedInState());
      }
      emit(ServerErrorState());
    }
  }

  _changeNameToState(ChangeNameEvent e, Emitter<UserBlocState> emit) async {
    emit(LoadingUserState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _userRepository.changeName(
        "Bearer $token",
        e.name
      );
      if(response.message == "name has been changed") {
        emit(SuccessChangeNameState());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedUserState());
      } else if (e.response?.statusCode == 504) {
        emit(NotLoggedInState());
      }
    }
  }

   _changePasswordToState(ChangePasswordEvent e, Emitter<UserBlocState> emit) async {
    emit(LoadingUserState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _userRepository.changePassword(
        "Bearer $token",
        e.password,
        e.newPassword,
        e.retype
      );
      if(response.message == "ok") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", response.token);
        emit(SuccessChangePasswordState());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 403) {
        emit(WrongPasswordState());
      } else if (e.response?.statusCode == 500) {
        emit(FailedUserState());
      } else if (e.response?.statusCode == 420) {
        emit(PasswordNotMatchedState());
      }
    }
  }
}