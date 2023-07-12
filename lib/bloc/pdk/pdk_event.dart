import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocEvent{}

class GetProcessPDKEvent extends PDKBlocEvent{
  final String branch;
  final int role;
  final String cat;

  GetProcessPDKEvent(
    this.branch,
    this.role,
    this.cat
  );
}