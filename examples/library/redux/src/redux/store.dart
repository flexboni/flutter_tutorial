import 'package:flutter/material.dart';

import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'posts/posts_actions.dart';
import 'posts/posts_reducer.dart';
import 'posts/posts_state.dart';

/// the root reducer of our entire application is where we use all of our reducers,
/// let’s say for example you have the same scenario for auth
/// (holds userProfile, isLoading, isError),
/// we should use userReducer here too.
AppState appReducer(AppState state, dynamic action) {
  if (action is SetPostsStateAction) {
    final nextPostsState = postsReducer(state.postsState, action);

    return state.copyWith(postsState: nextPostsState);
  }

  return state;
}

///this is our main state object, the one that holds entire applications state.
/// if we would have a piece of state for auth we should add it here too.
@immutable
class AppState {
  final PostsState postsState;

  AppState({
    @required this.postsState,
  });

  AppState copyWith({
    PostsState postsState,
  }) {
    return AppState(postsState: postsState ?? this.postsState);
  }
}

/// this is just a helper class we’ll be using in our main file to bootstrap redux.
/// it has 2 static methods, a getter that we can later use anywhere
/// in our app to access our store and consume it’s data or dispatch actions
/// and an init method that we use to initialize our store,
/// we made this a separate async method so maybe later
/// if we needed to persist our state we can read our initial state
/// from some data source (file, database or network)
/// and initialize our store asynchronously.
/// Actually, there is a library that helps us do this called 'Redux Persist'.
class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null)
      throw Exception("store is not initialized");
    else
      return _store;
  }

  static Future<void> init() async {
    final postsStateInitial = PostsState.initial();

    /// When creating a store you will need three things,
    /// your root reducer (appReducer),
    /// middlewares ([thunkMiddleware] or an empty array if you don’t plan to use any middlewares)
    /// and initial state which is AppState.
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware],
      initialState: AppState(postsState: postsStateInitial),
    );
  }
}
