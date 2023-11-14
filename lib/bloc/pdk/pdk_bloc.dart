import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data_sources/repository/pdk_repository.dart';
import 'pdk_bloc.dart';

export 'pdk_state.dart';
export 'pdk_event.dart';
export 'pdk_bloc.dart';

class PDKBloc extends Bloc<PDKBlocEvent, PDKBlocState> {
  final PDKRepository _PDKRepository;
  final SharedPreferences _sharedPreferences;

  static create(PDKRepository pdkRepository, SharedPreferences sharedPreferences) => PDKBloc(pdkRepository, sharedPreferences);

  PDKBloc(this._PDKRepository, this._sharedPreferences) : super(LoadingPDKState());

  @override
  Stream<PDKBlocState> mapEventToState(PDKBlocEvent event) async* {
    if(event is GetProcessPDKEvent) {
      yield* _getProgressToState(event);
    }
    if(event is GetDonePDKEvent) {
      yield* _getDoneToState(event);
    }
    if(event is GetDetailPDKEvent) {
      yield* _getDetailToState(event);
    }
    if(event is PostApprovePDKEvent) {
      yield* _postApproveToState(event);
    }
    if(event is PostRejectPDKEvent) {
      yield* _postRejectToState(event);
    }
  }

  Stream<PDKBlocState> _getProgressToState(GetProcessPDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");

    try {
      final response = await _PDKRepository.getListProcess("Bearer $token");
      if(response.message == "ok") {
        yield GetListProcessState(response.result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 504) {
        yield NotLoggedInPDKState();
      }
    }
  }

  Stream<PDKBlocState> _getDoneToState(GetDonePDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");

    try {
      final response = await _PDKRepository.getListDone("Bearer $token");
      if(response.message == "ok") {
        yield GetListDoneState(response.result!);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 504) {
        yield NotLoggedInPDKState();
      }
    }
  }

  Stream<PDKBlocState> _getDetailToState(GetDetailPDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.getDetailPDK("Bearer $token", e.id);
      if(response.message == "ok") {
        yield GetDetailState(response.result);
      }
    } on DioException catch (e) {
      print(e.message);
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 504) {
        yield NotLoggedInPDKState();
      }
    }
  }

  Stream<PDKBlocState> _postApproveToState(PostApprovePDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.approvePDK("Bearer $token", e.desc!, e.date, e.id, e.cat, e.branch, e.disc, e.idDet);
      if(response.message == "updated") {
        yield SuccessPostApproveState();
      }
    } on DioException catch (e) {
      print(e.message);
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 403) {
        yield NotLoggedInPDKState();
      } else if (e.response?.statusCode == 409) {
        yield PostFailedPDKState();
      }
    }
  }

  Stream<PDKBlocState> _postRejectToState(PostRejectPDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.rejectPDK("Bearer $token", e.desc, e.date, e.id, e.cat, e.branch);
      if(response.message == "rejected") {
        yield SuccessPostRejectState();
      }
    } on DioException catch (e) {
      print(e.message);
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 403) {
        yield NotLoggedInPDKState();
      } else if (e.response?.statusCode == 409) {
        yield PostFailedPDKState();
      }
    }
  }
}