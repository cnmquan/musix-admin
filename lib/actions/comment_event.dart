abstract class CommentEvent {
  const CommentEvent();
}

class GetCommentByPostEvent implements CommentEvent {
  final String postId;
  const GetCommentByPostEvent(this.postId);
}

class ChangeStatusCommentEvent implements CommentEvent {
  final String status;
  final String commentId;
  const ChangeStatusCommentEvent({
    required this.status,
    required this.commentId,
  });
}
