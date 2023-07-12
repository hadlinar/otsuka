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
  }

  Stream<PDKBlocState> _getProgressToState(GetProcessPDKEvent e) async* {
    yield LoadingPDKState();
    final token = _sharedPreferences.getString("access_token");

    try {
      final response = await _PDKRepository.getListProcess(
          token: "Bearer $token",
          branch: e.branch,
          role: e.role,
          cat: e.cat
      );
      if(response.message == "ok") {
        yield GetListProcessState(response.result);
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        yield FailedPDKState();
      } else if (e.response?.statusCode == 504) {
        yield NotLoggedInState();
      }
    }
  }
}