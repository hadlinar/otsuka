import 'package:ediscount/resources/app_config.dart';
import 'package:ediscount/views/app_module.dart';
import 'package:flutter/material.dart';

import 'ediscount_apps.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const url = "http://103.140.207.25:3000/otsuka/ediscount";
  final appModule = AppModule(url);
  await appModule.setup();
  final rootApp = appModule.configureBloc(EdiscountApps());

  final app = AppConfig(urlEndpoint: url, buildFlavor: 'production', child: rootApp);
  runApp(app);
}

