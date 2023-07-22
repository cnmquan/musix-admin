import 'package:equatable/equatable.dart';
import 'package:musix_admin/utils/utils.dart';

import '../models/comment.dart';

class CommentState extends Equatable {
  final String key;
  final Status status;
  final List<Comment> comments;
  final String? error;

  const CommentState({
    required this.key,
    required this.status,
    required this.comments,
    this.error,
  });

  CommentState copyWith({
    String? key,
    Status? status,
    List<Comment>? comments,
    String? error,
  }) {
    return CommentState(
      key: key ?? this.key,
      status: status ?? this.status,
      comments: comments ?? this.comments,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        key,
        status,
        comments,
        error,
      ];
}
