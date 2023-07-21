abstract class PostEvent {
  const PostEvent();
}

class GetPostsEvent implements PostEvent {
  const GetPostsEvent();
}

class ChangingStatusPostEvent implements PostEvent {
  final String status;
  final String postId;

  const ChangingStatusPostEvent(this.postId, this.status);
}
