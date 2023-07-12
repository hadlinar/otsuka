import 'package:ediscount/models/list_process.dart';

import '../network/pdk_service.dart';

class PDKRepository {
  final PDKService listProcessService;

  PDKRepository(this.listProcessService);

  Future<ListProcessResponse> getListProcess({
    required String token,
    required String branch,
    required int role,
    required String cat
  }) async {
    final response = await listProcessService.getListProcess(token, {
      "branch": branch,
      "role": role,
      "cat": cat
    });

    return response;
  }
}