import 'package:ediscount/models/pdk.dart';

import '../network/pdk_service.dart';

class PDKRepository {
  final PDKService pdkService;

  PDKRepository(this.pdkService);

  Future<ListProcessResponse> getListProcess(String token) async {
    final response = await pdkService.getListProcess(token);

    return response;
  }

  Future<ListDoneResponse> getListDone(String token, String filter) async {
    final response = await pdkService.getListDone(token, filter);

    return response;
  }

  Future<DetailPDKResponse> getDetailPDK(String token, String id) async {
    final response = await pdkService.getPDK(token, id);

    return response;
  }

  Future<ApprovalResponse> approvePDK(String token, String? desc, String date, int id, String cat, String branch, String disc, int idDet) async {
    final response = await pdkService.postApprove(token, id, idDet, {
      "desc": desc,
      "date": date,
      "cat": cat,
      "branch": branch,
      "disc": disc
    });

    return response;
  }

  Future<ApprovalResponse> rejectPDK(String token, String desc, String date, int id, String cat, String branch) async {
    final response = await pdkService.postReject(token, id, {
      "desc": desc,
      "date": date,
      "cat": cat,
      "branch": branch
    });

    return response;
  }
}