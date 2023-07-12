import 'package:ediscount/models/list_process.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../utils/global.dart';

part 'pdk_service.g.dart';

@RestApi(baseUrl: Global.baseUrl)

abstract class PDKService{
  static create(Dio dio) => _PDKService(dio);

  @GET('/list/process')
  Future<ListProcessResponse> getListProcess(@Header("Authorization") String authorization, @Body() Map<String, dynamic> body);
}