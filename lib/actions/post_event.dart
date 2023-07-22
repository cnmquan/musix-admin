abstract class PostEvent {
  const PostEvent();
}

class GetPostsEvent implements PostEvent {
  const GetPostsEvent();
}

class ChangingStatusPostEvent implements PostEvent {
  final String postId;

  const ChangingStatusPostEvent(this.postId);
}
