import 'package:dio/dio.dart';
import 'package:musix_admin/env.dart';

class InitialRepo {
  late final Dio dio;
  final String exception = 'Bad Request';

  InitialRepo() {
    _initDio();
  }

  void _initDio() {
    final options = BaseOptions(
      baseUrl: Env.serverUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(options);
  }

  Map<String, String> headerMultiFormData({required String token}) =>
      <String, String>{
        'Content-Type': 'multipart/form-data',
        'Authorization': "Bearer $token",
      };

  Map<String, String> headerApplicationJson({required String token}) =>
      <String, String>{
        "Content-Type": "application/json",
        'authorization': "Bearer $token",
      };
}
