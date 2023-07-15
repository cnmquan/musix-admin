import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:musix_admin/repos/repos.dart';

final getIt = GetIt.instance;
FutureOr<void> registerDependency() async {
  getIt.registerLazySingleton<UserRepo>(() => UserRepo());
}
