import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/common/locator/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  final localDbSetUp = locator<LocalDbSetup>();
  await localDbSetUp.init();
  initializeDateFormatting().then((_) => runApp(MyApp()));
}
