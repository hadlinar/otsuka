import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserEvent{}

class GetUserEvent extends UserEvent{}

class LogoutEvent extends UserEvent{}