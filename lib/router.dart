import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Router {
  static const login = "/login";

  static Route<dynamic> generateRouter(RouteSettings settings) {
    Widget widget = Login();
    switch(settings.name) {
      case login:
        widget = Login();
        break;
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}