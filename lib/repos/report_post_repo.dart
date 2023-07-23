import 'dart:async';

import 'package:dio/dio.dart';
import 'package:musix_admin/models/report_post.dart';
import 'package:musix_admin/repos/initial_repo.dart';

import '../env.dart';

class ReportPostRepo extends InitialRepo {
  FutureOr<List<ReportPost>> getReportPosts(String token) async {
    const url = "${Env.serverUrl}/social/report-post/all";
    List<ReportPost> reportPosts = List.empty(growable: true);
    try {
      final response = await dio.get(url,
          options: Options(headers: headerApplicationJson(token: token)));
      final resData = response.data;
      if (resData["data"]["reportPosts"] != null) {
        final reportPostsData = resData["data"]["reportPosts"];
        for (var reportPostData in reportPostsData) {
          final reportPost = ReportPost.fromJson(reportPostData);
          reportPosts.add(reportPost);
        }
      }
      return reportPosts;
    } catch (e) {
      print("error occured $e");
      return reportPosts;
    }
  }

  FutureOr<List<ReportPost>> getReportsByPostId(
      String token, String postId) async {
    const url = "${Env.serverUrl}/social/report-post";
    List<ReportPost> reportPosts = List.empty(growable: true);
    try {
      final response = await dio.get(url,
          options: Options(headers: headerApplicationJson(token: token)),
          queryParameters: {"postId": postId});
      final resData = response.data;
      if (resData["data"]?["reportPosts"] != null) {
        final reportPostsData = resData["data"]["reportPosts"];
        for (var reportPostData in reportPostsData) {
          final reportPost = ReportPost.fromJson(reportPostData);
          print("report is $reportPost");
          reportPosts.add(reportPost);
        }
      }
      return reportPosts;
    } catch (e) {
      print("error occured $e");
      return reportPosts;
    }
  }
}
