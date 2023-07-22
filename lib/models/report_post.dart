import 'package:equatable/equatable.dart';
import 'package:musix_admin/models/post.dart';
import 'package:musix_admin/models/user.dart';

class ReportPost extends Equatable {
  final String id;
  final Post post;
  final String reason;
  final int dateCreated;
  final User user;

  factory ReportPost.fromJson(Map<String, dynamic> json) {
    final postRawData = json["post"];
    final userRawData = json["user"];
    print("post ${postRawData["postStatus"]}");
    print("user $userRawData");
    final post = Post(
      id: postRawData["id"],
      ownerId: postRawData["ownerId"],
      ownerName: postRawData["ownerUsername"],
      fileId: postRawData["fileId"],
      fileName: postRawData["fileName"],
      fileUrl: postRawData["fileUrl"],
      thumbnailId: postRawData["thumbnailId"],
      thumbnailUrl: postRawData["thumbnailUrl"],
      content: postRawData["content"],
      likeBy: List<String>.from(postRawData["likedBy"].map((x) => x)),
      comments: List<String>.from(postRawData["comments"].map((x) => x)),
      dateCreated: postRawData["dateCreated"],
      lastModified: postRawData["lastModified"],
      postStatus: postRawData["postStatus"],
    );
    final user = User(
      id: userRawData["id"],
      username: userRawData["username"],
      password: userRawData["password"],
      name: userRawData["profile"]?["fullName"],
    );
    return ReportPost(
        id: json["id"],
        post: post,
        reason: json["reason"],
        dateCreated: json["dateCreated"],
        user: user);
  }

  const ReportPost({
    required this.id,
    required this.post,
    required this.reason,
    required this.dateCreated,
    required this.user,
  });
  ReportPost copyWith(
      {String? id, Post? post, String? reason, int? dateCreated, User? user}) {
    return ReportPost(
      id: id ?? this.id,
      post: post ?? this.post,
      reason: reason ?? this.reason,
      dateCreated: dateCreated ?? this.dateCreated,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [id, post, reason, dateCreated, user];
}
