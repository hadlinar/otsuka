import 'package:ediscount/models/pdk.dart';

import '../network/pdk_service.dart';

class PDKRepository {
  final PDKService listProcessService;

  PDKRepository(this.listProcessService);

  Future<ListProcessResponse> getListProcess(
    String token
  ) async {
    final response = await listProcessService.getListProcess(token);

    return response;
  }
}