import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musix_admin/di.dart';

import 'app.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await registerDependency();
  final debugLogger = DebugLogger();
  FlutterError.onError = (details) {
    debugLogger.error(details.exceptionAsString(), details.stack);
  };
  Bloc.observer = AppObserver();

  runApp(const MusicAdminApp());
}
