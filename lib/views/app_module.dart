import 'package:ediscount/bloc/login/login_bloc.dart';
import 'package:ediscount/data_sources/network/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/pdk/pdk_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../data_sources/network/pdk_service.dart';
import '../data_sources/network/user_service.dart';
import '../data_sources/repository/login_repository.dart';
import '../data_sources/repository/pdk_repository.dart';
import '../data_sources/repository/user_repository.dart';

class AppModule {

  final String? baseUrl;

  AppModule(this.baseUrl);

  static final GetIt injector = GetIt.instance;

  Future<void> configureOthers() async {
    final dio = Dio();
    injector.registerSingleton(dio);
    injector.registerSingleton(await SharedPreferences.getInstance());
  }

  void configureService() {
    injector.registerSingleton<LoginService>(
      LoginService.create(injector.get())
    );
    injector.registerSingleton<UserService>(
        UserService.create(injector.get())
    );
    injector.registerSingleton<PDKService>(
        PDKService.create(injector.get())
    );
  }

  void configureRepository() {
    injector.registerSingleton(LoginRepository(injector.get()));
    injector.registerSingleton(UserRepository(injector.get()));
    injector.registerSingleton(PDKRepository(injector.get()));
  }

  Widget configureBloc(Widget app) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginBloc> (
        create: (_) => LoginBloc.create(injector.get()),
      ),
      BlocProvider<UserBloc> (
        create: (_) => UserBloc.create(injector.get(), injector.get()),
      ),
      BlocProvider<PDKBloc> (
        create: (_) => PDKBloc.create(injector.get(), injector.get()),
      )
    ], child: app);
  }

  Future<void> setup() async {
    await configureOthers();
    configureService();
    configureRepository();
  }

}