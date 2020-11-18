import 'package:meta/meta.dart';

import '../../models/i_post.dart';

// 'PostsState' is an immutable class that has the responsibility to hold our posts state.
// 'factory' constructor will be later used to fill the initial main state.
// 'copyWith' method will be later used to get a copy of our PostsState
//   to update this piece of the main state.
@immutable
class PostsState {
  final bool isError;
  final bool isLoading;
  final List<IPost> posts;

  PostsState({
    this.isError,
    this.isLoading,
    this.posts,
  });

  factory PostsState.initial() => PostsState(
        isLoading: false,
        isError: false,
        posts: const [],
      );

  PostsState copyWith({
    @required bool isError,
    @required bool isLoading,
    @required List<IPost> posts,
  }) {
    return PostsState(
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
      posts: posts ?? this.posts
    );
  }
}
