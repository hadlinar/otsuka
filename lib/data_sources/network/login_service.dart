import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/login.dart';
import '../../utils/global.dart';

part 'login_service.g.dart';

@RestApi(baseUrl : Global.baseUrl)

abstract class LoginService {
  static create(Dio dio) => _LoginService(dio);

  @POST('/login')
  Future<LoginResponse> login(@Body() Map<String, dynamic> body);

}