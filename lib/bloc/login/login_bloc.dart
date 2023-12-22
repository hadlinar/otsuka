import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_sources/repository/login_repository.dart';
import 'login_bloc.dart';

export 'login_state.dart';
export 'login_event.dart';
export 'login_bloc.dart';

class LoginBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final LoginRepository _loginRepository;

  static create(LoginRepository repo) => LoginBloc(repo);

  LoginBloc(this._loginRepository) : super(InitialLoginState()) {
    on<LoginEvent>(_loginEvent);
  }

  _loginEvent(LoginEvent event, Emitter<LoginBlocState> emit) async {
    emit(LoadingLoginState());
    try{
      final response = await _loginRepository.login(
        username: event.username,
        password: event.password
      );

      if(response.message == "ok") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", response.token);
        emit(SuccessLoginState());
      }
    } on DioException catch (e){
      if (e.response?.statusCode == 401) {
        emit(WrongPasswordLoginState());
      } else if (e.response?.statusCode == 500) {
        emit(FailedLoginState());
      } else if (e.response?.statusCode == 504) {
        emit(NotLoggedInState());
      } else if (e.response?.statusCode == 400) {
        emit(NotMatchedLoginState());
      } else if (e.response?.statusCode == 404) {
        emit(NoUsernameState());
      }
    }
  }
}