import 'package:ediscount/models/list_process.dart';
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

class NotLoggedInState extends PDKBlocState{
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