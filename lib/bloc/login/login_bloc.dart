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

  LoginBloc(this._loginRepository) : super(LoadingLoginState());

  @override
  Stream<LoginBlocState> mapEventToState(LoginBlocEvent event) async* {
    if(event is LoginEvent) {
      yield* _loginToState(event);
    }
  }

  Stream<LoginBlocState> _loginToState(LoginEvent e) async* {
    yield LoadingLoginState();
    try {
      final response = await _loginRepository.login(
          username: e.username,
          password: e.password
      );
      if(response.message == "ok") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access_token", response.token);
        yield SuccessLoginState();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        yield WrongPasswordLoginState();
      } else if (e.response?.statusCode == 500) {
        yield FailedLoginState();
      } else if (e.response?.statusCode == 504) {
        yield NotLoggedInState();
      } else if (e.response?.statusCode == 400) {
        yield NotMatchedLoginState();
      } else if (e.response?.statusCode == 404) {
        yield NoUsernameState();
      }
    }
  }
}