import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:musix_admin/repos/report_post_repo.dart';
import 'package:musix_admin/repos/repos.dart';

final getIt = GetIt.instance;
FutureOr<void> registerDependency() async {
  getIt.registerLazySingleton<UserRepo>(() => UserRepo());
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo());
  getIt.registerLazySingleton<PostRepo>(() => PostRepo());
  getIt.registerLazySingleton<ReportPostRepo>(() => ReportPostRepo());
  getIt.registerLazySingleton<CommentRepo>(() => CommentRepo());
}
