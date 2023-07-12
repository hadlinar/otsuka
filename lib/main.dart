import 'package:ediscount/resources/app_config.dart';
import 'package:ediscount/views/app_module.dart';
import 'package:flutter/material.dart';

import 'ediscount_apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const url = "http://10.0.2.2:3000/otsuka/ediscount";
  final appModule = AppModule(url);
  await appModule.setup();
  final rootApp = appModule.configureBloc(EdiscountApps());

  final app = AppConfig(urlEndpoint: url, buildFlavor: 'development', child: rootApp);
  runApp(app);
}

