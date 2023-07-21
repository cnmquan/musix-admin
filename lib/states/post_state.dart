import 'package:equatable/equatable.dart';
import 'package:musix_admin/utils/status.dart';

import '../models/models.dart';

class PostState extends Equatable {
  final String key;
  final Status status;
  final List<Post> posts;
  final String? error;

  const PostState({
    required this.key,
    required this.status,
    required this.posts,
    this.error,
  });

  PostState copyWith({
    String? key,
    Status? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostState(
      key: key ?? this.key,
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        key,
        status,
        posts,
        error,
      ];
}
