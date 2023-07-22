import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  final String id;
  final String ownerId;
  final String ownerUsername;
  final List<String> replies;
  final List<String> likeBy;
  final int dateCreated;
  final String content;
  final int lastModified;
  final String status;
  final String? replyComment;

  const Comment({
    required this.id,
    required this.ownerId,
    required this.ownerUsername,
    required this.replies,
    required this.likeBy,
    required this.dateCreated,
    required this.content,
    required this.lastModified,
    required this.status,
    this.replyComment,
  });

  Comment copyWith({
    String? id,
    String? ownerId,
    String? ownerUsername,
    List<String>? replies,
    List<String>? likeBy,
    int? dateCreated,
    String? content,
    int? lastModified,
    String? status,
    String? replyComment,
  }) {
    return Comment(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      ownerUsername: ownerUsername ?? this.ownerUsername,
      replies: replies ?? this.replies,
      likeBy: likeBy ?? this.likeBy,
      dateCreated: dateCreated ?? this.dateCreated,
      content: content ?? this.content,
      lastModified: lastModified ?? this.lastModified,
      status: status ?? this.status,
      replyComment: replyComment ?? this.replyComment,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        ownerUsername,
        replies.length,
        likeBy.length,
        dateCreated,
        content,
        lastModified,
        status,
        replyComment,
      ];
}
