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
}
