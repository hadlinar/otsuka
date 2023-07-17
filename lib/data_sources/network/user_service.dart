import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/user.dart';
import '../../utils/global.dart';

part 'user_service.g.dart';

@RestApi(baseUrl: Global.baseUrl)

abstract class UserService{
  static create(Dio dio) => _UserService(dio);

  @GET('/user')
  Future<UserResponse> getUser(@Header("Authorization") String authorization);

  @POST('/logout')
  Future<LogoutResponse> logout(@Header("Authorization") String authorization);
}