import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PDKBlocEvent{}

class GetProcessPDKEvent extends PDKBlocEvent{}