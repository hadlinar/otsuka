import 'package:ediscount/models/pdk.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocState extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoadingPDKState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessPDKState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class FailedPDKState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class NotLoggedInPDKState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class ServerErrorState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class GetListProcessState extends PDKBlocState{
  List<PDK> getListProcess;

  GetListProcessState(this.getListProcess);
}

class GetDetailState extends PDKBlocState{
  List<DetailPDK> getPDKDetail;

  GetDetailState(this.getPDKDetail);
}

class SuccessPostApproveState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class SuccessPostRejectState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}

class PostFailedPDKState extends PDKBlocState{
  @override
  List<Object?> get props => [];
}