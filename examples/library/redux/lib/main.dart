import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_tutorial/src/models/i_post.dart';
import 'package:flutter_tutorial/src/redux/posts/posts_actions.dart';
import 'package:flutter_tutorial/src/redux/store.dart';

void main() async {
  /**
   * In our main function (where Dart programs start) first,
   * we initialize our Redux store with the helper Redux class
   * which we wrote previously on store.dart
   */
  await Redux.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Redux Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      /**
       * In our MaterialApp home, we’re using StoreProvider
       * to inject our Store to the entire tree of our application 
       */
      home: StoreProvider<AppState>(
        store: Redux.store,
        child: MyHomePage(title: 'Flutter Redux Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _onFetchPostsPressed() {
    Redux.store.dispatch(fetchPostsAction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: <Widget>[
          RaisedButton(
              child: Text("Fetch Posts"),
              /**
               * We have a method called '_onFetchPostsPressed'
               * which we’re using as a callback for whenever the user presses the 'Fetch Posts Button'.
               */
              onPressed: _onFetchPostsPressed),
          /**
               * Three connected widgets which are consuming data
               * from the store with StoreConnector,
               * 'Loading widget', 'Error message widget', 'List of posts widget'
               * 
               *  Don’t forget to pass your data types as generic arguments!!
               */
          StoreConnector<AppState, bool>(
              /**
               * 'distinct' will listen for changes,
               * but if the ViewModel hasn't changed,
               * it won't trigger a rebuild.
               * we want our 'StoreConnectors' to rebuild
               * whenever that special piece of data that they are consuming is changed.
               * To achieve this we have to pass 'distinct' as 'true'
               * to tell Flutter Redux to do a comparison
               * between the new and old values and rebuild the widget if the value is actually changed.
               */
              distinct: true,
              builder: (context, isLoading) {
                if (isLoading)
                  return CircularProgressIndicator();
                else
                  return SizedBox.shrink();
              },
              /**
               * Notice how the StoreConnector widget is getting connected to our Store,
               * it has a 'converter' which does that job,
               * it passes our store as a param and we can return which part of our state we want to consume.
               */
              converter: (store) => store.state.postsState.isLoading),
          StoreConnector<AppState, bool>(
              distinct: true,
              converter: (store) => store.state.postsState.isError,
              builder: (context, isError) {
                if (isError)
                  return Text("Failed to get posts");
                else
                  return SizedBox.shrink();
              }),
          Expanded(
              child: StoreConnector<AppState, List<IPost>>(
            distinct: true,
            converter: (store) => store.state.postsState.posts,
            builder: (context, posts) {
              return ListView(
                children: _buildPosts(posts),
              );
            },
          ))
        ],
      ),
    );
  }

  List<Widget> _buildPosts(List<IPost> posts) {
    return posts
        .map((post) => ListTile(
              title: Text(post.title),
              subtitle: Text(post.body),
              key: Key(post.id.toString()),
            ))
        .toList();
  }
}
