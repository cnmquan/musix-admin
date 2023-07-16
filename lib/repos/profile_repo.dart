import 'dart:async';

import 'package:dio/dio.dart';
import 'package:musix_admin/env.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/repos/initial_repo.dart';

class ProfileRepo extends InitialRepo {
  FutureOr<List<Profile>> getProfiles(String token) async {
    const url = '${Env.serverUrl}/profile/list';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      final resData = response.data;
      if (resData?["data"]?["users"] != null) {
        final users = resData?["data"]?["users"];
        final profiles = <Profile>[];
        for (final e in users) {
          final profile = Profile(
            id: e["id"],
            username: e["username"],
            role: e["role"],
            enable: e["enable"],
            email: e["email"],
            fullName: e["fullName"],
          );
          profiles.add(profile);
        }
        return profiles;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  FutureOr<Profile> createAdmin({
    required String token,
    required String username,
    required String password,
    String? name,
  }) async {
    const url = '${Env.serverUrl}/auth/set-admin';
    final data = {"username": username, "password": password, "name": name};

    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      final resData = response.data;
      return Profile(
        id: resData["data"]?["user"]?["id"],
        username: resData["data"]?["user"]?["username"],
        role: resData["data"]?["user"]?["role"],
        enable: resData["data"]?["user"]?["enabled"],
        fullName: resData["data"]?["user"]?["profile"]?["fullName"],
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  FutureOr<Profile> disableUser(
    String userId,
    String token,
  ) async {
    const url = '${Env.serverUrl}/profile/disable';
    final data = {"id": userId};
    try {
      final response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      final resData = response.data;
      return Profile(
        id: resData["data"]?["user"]?["id"],
        username: resData["data"]?["user"]?["username"],
        role: resData["data"]?["user"]?["role"],
        enable: resData["data"]?["user"]?["enable"],
        fullName: resData["data"]?["user"]?["fullName"],
        email: resData["data"]?["user"]?["email"],
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }
}
