import 'package:ediscount/models/pdk.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../utils/global.dart';

part 'pdk_service.g.dart';

@RestApi(baseUrl: Global.baseUrl)

abstract class PDKService{
  static create(Dio dio) => _PDKService(dio);

  @GET('/process')
  Future<ListProcessResponse> getListProcess(@Header("Authorization") String authorization);

  @GET('/detail/{id}')
  Future<DetailPDKResponse> getPDK(@Header("Authorization") String authorization, @Path('id') String id);

  @POST('/approve/{id}/{det}')
  Future<ApprovalResponse> postApprove(@Header("Authorization") String authorization, @Path('id') int id, @Path('det') int det, @Body() Map<String, dynamic> body);

  @POST('/reject/{id}')
  Future<ApprovalResponse> postReject(@Header("Authorization") String authorization, @Path('id') int id, @Body() Map<String, dynamic> body);
}