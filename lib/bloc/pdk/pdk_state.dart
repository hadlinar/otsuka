import 'package:ediscount/models/pdk.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocState extends Equatable{
  const PDKBlocState();

  @override
  List<Object> get props => [];
}

class LoadingPDKState extends PDKBlocState{}

class SuccessPDKState extends PDKBlocState{}

class FailedPDKState extends PDKBlocState{}

class NotLoggedInPDKState extends PDKBlocState{}

class ServerErrorState extends PDKBlocState{}

class GetListProcessState extends PDKBlocState{
  List<PDK> getListProcess;

  GetListProcessState(this.getListProcess);

  @override
  List<Object> get props => [getListProcess];
}

class GetListDoneState extends PDKBlocState{
  List<PDK> getListDone;

  GetListDoneState(this.getListDone);

  @override
  List<Object> get props => [getListDone];
}

class GetDetailState extends PDKBlocState{
  List<DetailPDK> getPDKDetail;

  GetDetailState(this.getPDKDetail);

  @override
  List<Object> get props => [getPDKDetail];
}

class SuccessPostApproveState extends PDKBlocState{}

class SuccessPostRejectState extends PDKBlocState{}

class PostFailedPDKState extends PDKBlocState{}