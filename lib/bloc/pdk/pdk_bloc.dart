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

  PDKBloc(this._PDKRepository, this._sharedPreferences) : super(LoadingPDKState()) {
    on<GetProcessPDKEvent>(_getProgressToState);
    on<GetDonePDKEvent>(_getDoneToState);
    on<GetDetailPDKEvent>(_getDetailToState);
    on<PostApprovePDKEvent>(_postApproveToState);
    on<PostRejectPDKEvent>(_postRejectToState);
  }

  _getProgressToState(GetProcessPDKEvent e, Emitter<PDKBlocState> emit) async {
    emit(LoadingPDKState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.getListProcess("Bearer $token");
      if(response.message == "ok") {
        emit(GetListProcessState(response.result));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedPDKState());
      } else if (e.response?.statusCode == 504) {
        emit(NotLoggedInPDKState());
      }
    }
  }

  _getDoneToState(GetDonePDKEvent e, Emitter<PDKBlocState> emit) async {
    emit(LoadingPDKState());
    final token = _sharedPreferences.getString("access_token");

    try {
      final response = await _PDKRepository.getListDone("Bearer $token", e.filter);
      if(response.message == "ok") {
        emit(GetListDoneState(response.result));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedPDKState());
      } else if (e.response?.statusCode == 504) {
        emit(NotLoggedInPDKState());
      }
    }
  }

  _getDetailToState(GetDetailPDKEvent e, Emitter<PDKBlocState> emit) async {
    emit(LoadingPDKState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.getDetailPDK("Bearer $token", e.id);
      if(response.message == "ok") {
        emit(GetDetailState(response.result));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedPDKState());
      } else if (e.response?.statusCode == 504) {
        emit(NotLoggedInPDKState());
      }
    }
  }

  _postApproveToState(PostApprovePDKEvent e, Emitter<PDKBlocState> emit) async {
    emit(LoadingPDKState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.approvePDK("Bearer $token", e.desc, e.date, e.id, e.cat, e.branch, e.disc, e.idDet);
      if(response.message == "updated") {
        emit(SuccessPostApproveState());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedPDKState());
      } else if (e.response?.statusCode == 403) {
        emit(NotLoggedInPDKState());
      } else if (e.response?.statusCode == 409) {
        emit(PostFailedPDKState());
      }
    }
  }

  _postRejectToState(PostRejectPDKEvent e, Emitter<PDKBlocState> emit) async {
    emit(LoadingPDKState());
    final token = _sharedPreferences.getString("access_token");
    try {
      final response = await _PDKRepository.rejectPDK("Bearer $token", e.desc, e.date, e.id, e.cat, e.branch);
      if(response.message == "rejected") {
        emit(SuccessPostRejectState());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        emit(FailedPDKState());
      } else if (e.response?.statusCode == 403) {
        emit(NotLoggedInPDKState());
      } else if (e.response?.statusCode == 409) {
        emit(PostFailedPDKState());
      }
    }
  }
}