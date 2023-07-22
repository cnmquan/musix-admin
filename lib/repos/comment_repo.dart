import 'dart:async';

import 'package:dio/dio.dart';
import 'package:musix_admin/env.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/repos/initial_repo.dart';

class CommentRepo extends InitialRepo {
  FutureOr<List<Comment>> getCommentByPost(String token, String id) async {
    final url = '${Env.serverUrl}/social/comment/byPost/$id';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      final resData = response.data;
      if (resData["data"]?["comments"] != null) {
        final commentDatas = resData["data"]?["comments"];
        List<Comment> comments = [];
        for (final commentData in commentDatas) {
          final comment = Comment(
            id: commentData["id"],
            ownerId: commentData["ownerId"],
            ownerUsername: commentData["ownerUsername"],
            replies: commentData["replies"] == null
                ? []
                : List<String>.from(commentData["replies"].map((x) => x)),
            likeBy: commentData["likedBy"] == null
                ? []
                : List<String>.from(commentData["likedBy"].map((x) => x)),
            dateCreated: commentData["dateCreated"],
            content: commentData["content"],
            lastModified: commentData["lastModified"],
            status: commentData["status"] ?? 'VISIBLE',
          );
          comments.add(comment);
        }
        return comments;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  FutureOr<List<Comment>> getReplyComment(String token, String id) async {
    final url = '${Env.serverUrl}/social/comment/reply/byComment/$id';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );
      final resData = response.data;
      if (resData["data"]?["comments"] != null) {
        final commentDatas = resData["data"]?["comments"];
        List<Comment> comments = [];
        for (final commentData in commentDatas) {
          final comment = Comment(
            id: commentData["id"],
            ownerId: commentData["ownerId"],
            ownerUsername: commentData["ownerUsername"],
            replies: commentData["replies"] == null
                ? []
                : List<String>.from(commentData["replies"].map((x) => x)),
            likeBy: commentData["likedBy"] == null
                ? []
                : List<String>.from(commentData["likedBy"].map((x) => x)),
            dateCreated: commentData["dateCreated"],
            content: commentData["content"],
            lastModified: commentData["lastModified"],
            status: commentData["status"] ?? 'VISIBLE',
            replyComment: id,
          );
          comments.add(comment);
        }
        return comments;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  FutureOr<bool> changeStatus(
      String token, String commentId, String status) async {
    const url = '${Env.serverUrl}/social/';

    try {
      // final response = dio.post(
      //   url,
      //   options: Options(
      //     headers: headerApplicationJson(token: token),
      //   ),
      // );
      return true;
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }
}
