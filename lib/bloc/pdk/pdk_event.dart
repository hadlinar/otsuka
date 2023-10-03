import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocEvent{}

class GetProcessPDKEvent extends PDKBlocEvent{}

class GetDonePDKEvent extends PDKBlocEvent{}

class GetDetailPDKEvent extends PDKBlocEvent{
  String id;

  GetDetailPDKEvent(this.id);
}

class PostApprovePDKEvent extends PDKBlocEvent{
  void desc;
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
}