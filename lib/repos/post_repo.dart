import 'dart:async';

import 'package:dio/dio.dart';
import 'package:musix_admin/env.dart';
import 'package:musix_admin/models/models.dart';
import 'package:musix_admin/repos/initial_repo.dart';

class PostRepo extends InitialRepo {
  FutureOr<List<Post>> getPosts(String token) async {
    const url = '${Env.serverUrl}/social/post/all';

    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headerApplicationJson(token: token),
        ),
      );

      final resData = response.data;
      if (resData["data"]?["posts"] != null) {
        final postDatas = resData["data"]?["posts"];
        List<Post> posts = [];
        for (final postData in postDatas) {
          final post = Post(
            id: postData["id"],
            ownerId: postData["ownerId"],
            ownerName: postData["ownerUsername"],
            fileId: postData["fileId"],
            fileName: postData["fileName"],
            fileUrl: postData["fileUrl"],
            thumbnailId: postData["thumbnailId"],
            thumbnailUrl: postData["thumbnailUrl"],
            content: postData["content"],
            likeBy: List<String>.from(postData["likedBy"].map((x) => x)),
            comments: List<String>.from(postData["comments"].map((x) => x)),
            dateCreated: postData["dateCreated"],
            lastModified: postData["lastModified"],
            postStatus: postData["postStatus"],
          );
          posts.add(post);
        }
        return posts;
      } else {
        return [];
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data["msg"] ?? exception);
    }
  }

  FutureOr<bool> changeStatusPost(String postId, String token) async {
    final url = '${Env.serverUrl}/social/post/status/$postId';
    try {
      final response = await dio.put(url,
          options: Options(headers: headerApplicationJson(token: token)));
      final resData = response.data;
      if (resData["data"]?["post"] != null) return true;
      return false;
    } catch (e) {
      return false;
    }
  }
}
