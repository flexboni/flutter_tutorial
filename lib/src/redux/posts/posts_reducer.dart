import '../posts/posts_actions.dart';
import '../posts/posts_state.dart';

postsReducer(PostsState prevState, SetPostsStateAction action) {
  final payload = action.postsState;
  return prevState.copyWith(
      isError: payload.isError,
      isLoading: payload.isLoading,
      posts: payload.posts);
}
