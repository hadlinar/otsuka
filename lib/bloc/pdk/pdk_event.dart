import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocEvent extends Equatable{
  const PDKBlocEvent();

  @override
  List<Object> get props => [];
}

class GetProcessPDKEvent extends PDKBlocEvent{}

class GetDonePDKEvent extends PDKBlocEvent{
  String filter;

  GetDonePDKEvent(this.filter);

  @override
  List<Object> get props => [filter];
}

class GetDetailPDKEvent extends PDKBlocEvent{
  String id;

  GetDetailPDKEvent(this.id);

  @override
  List<Object> get props => [id];
}

class PostApprovePDKEvent extends PDKBlocEvent{
  String? desc;
  String date;
  int id;
  String cat;
  String branch;
  String disc;
  int idDet;

  PostApprovePDKEvent(
    this.desc,
    this.date,
    this.id,
    this.cat,
    this.branch,
    this.disc,
    this.idDet,
  );

  @override
  List<Object> get props => [desc!, date, id, cat, branch, disc, idDet];
}

class PostRejectPDKEvent extends PDKBlocEvent{
  String desc;
  String date;
  int id;
  String cat;
  String branch;

  PostRejectPDKEvent(
      this.desc,
      this.date,
      this.id,
      this.cat,
      this.branch,
  );

  @override
  List<Object> get props => [desc, date, id, cat, branch];
}