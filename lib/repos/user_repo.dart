import 'package:dio/dio.dart';
import 'package:musix_admin/env.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/repos/initial_repo.dart';

class UserRepo extends InitialRepo {
  Future<User> signIn({
    required String username,
    required String password,
  }) async {
    const url = '${Env.serverUrl}/auth/login';
    final data = {
      "username": username,
      "password": password,
    };
    try {
      final response = await dio.post(url, data: data);
      final responseData = response.data;
      return User(
        id: responseData["data"]?["user"]?["id"],
        username: responseData["data"]?["user"]?["username"],
        password: password,
        name: responseData["data"]?["user"]?["profile"]?["fullName"],
        token: responseData["data"]?["token"]?["token"],
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  Future<bool> logout(String token) async {
    const url = '${Env.serverUrl}/auth/logout';

    try {
      await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      return true;
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }
}
