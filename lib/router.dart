import 'package:ediscount/views/page/home.dart';
import 'package:ediscount/views/page/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Router {
  static const home = "/";
  static const login = "/login";

  static Route<dynamic> generateRouter(RouteSettings settings) {
    Widget widget = Home();
    switch(settings.name) {
      case home:
        widget = Home();
        break;
      case login:
        widget = Login();
        break;
    }

    return MaterialPageRoute(builder: (_) => widget);
  }
}