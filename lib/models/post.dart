import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String id;
  final String ownerId;
  final String ownerName;
  final String fileId;
  final String fileUrl;
  final String fileName;
  final String content;
  final String thumbnailId;
  final int? dateCreated;
  final int? lastModified;
  final List<String> comments;
  final List<String> likeBy;
  final String thumbnailUrl;

  // Status: BLOCK, OPEN
  final String postStatus;

  const Post(
      {required this.id,
      required this.ownerId,
      required this.ownerName,
      required this.fileId,
      required this.fileName,
      required this.fileUrl,
      required this.thumbnailId,
      required this.thumbnailUrl,
      required this.content,
      this.dateCreated,
      this.lastModified,
      required this.likeBy,
      required this.comments,
      this.postStatus = "OPEN"});

  Post copyWith({
    String? id,
    String? ownerId,
    String? ownerName,
    String? fileId,
    String? fileUrl,
    String? fileName,
    int? dateCreated,
    int? lastModified,
    String? content,
    List<String>? comments,
    List<String>? likeBy,
    String? thumbnailUrl,
    String? thumbnailId,
    String? postStatus,
  }) {
    return Post(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerName,
      ownerName: ownerName ?? this.ownerName,
      fileId: fileId ?? this.fileId,
      fileName: fileName ?? this.fileName,
      content: content ?? this.content,
      fileUrl: fileUrl ?? this.fileUrl,
      thumbnailId: thumbnailId ?? this.thumbnailId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      likeBy: likeBy ?? this.likeBy,
      dateCreated: dateCreated ?? this.dateCreated,
      lastModified: lastModified ?? this.lastModified,
      comments: comments ?? this.comments,
      postStatus: postStatus ?? this.postStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        ownerName,
        content,
        fileId,
        fileUrl,
        fileName,
        thumbnailId,
        thumbnailUrl,
        likeBy,
        dateCreated,
        lastModified,
        comments,
        postStatus,
      ];
}
