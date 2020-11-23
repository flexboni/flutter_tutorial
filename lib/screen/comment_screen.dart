import 'dart:html';

import 'package:Fluttergram/component/no_data_progress.dart';
import 'package:Fluttergram/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CommentScreen extends StatefulWidget {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  CommentScreen({this.postId, this.postOwner, this.postMediaUrl});

  @override
  _CommentScreenState createState() => _CommentScreenState(
        postId: this.postId,
        postOwner: this.postOwner,
        postMediaUrl: this.postMediaUrl,
      );
}

class _CommentScreenState extends State<CommentScreen> {
  final String postId;
  final String postOwner;
  final String postMediaUrl;

  bool didFetchComments = false;
  List<Comment> fetchedComments = [];

  final TextEditingController _commentController = TextEditingController();

  _CommentScreenState({
    this.postId,
    this.postOwner,
    this.postMediaUrl,
  });

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: buildComments(),
        ),
        Divider(),
        ListTile(
          title: TextFormField(
            controller: _commentController,
            decoration: InputDecoration(labelText: "Write a comment..."),
            onFieldSubmitted: addComment,
          ),
          trailing: OutlineButton(
            onPressed: () {
              addComment(_commentController.text);
            },
            borderSide: BorderSide.none,
            child: Text("Post"),
          ),
        )
      ],
    );
  }

  Widget buildComments() {
    if (this.didFetchComments == false) {
      return FutureBuilder<List<Comment>>(
          future: getComments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return NoDataProgress();
            }

            this.didFetchComments = true;
            this.fetchedComments = snapshot.data;

            return ListView(
              children: snapshot.data,
            );
          });
    } else {
      // for optimistic updating
      return ListView(
        children: this.fetchedComments,
      );
    }
  }

  Future<List<Comment>> getComments() async {
    List<Comment> comments = [];

    QuerySnapshot data = await Firestore.instance
        .collection('insta_comments')
        .document(postId)
        .collection("comments")
        .getDocuments();

    data.documents.forEach((element) {
      comments.add(Comment.fromDocument(element));
    });

    return comments;
  }

  addComment(String comment) {
    _commentController.clear();

    Firestore.instance
        .collection("insta_comments")
        .document(postId)
        .collection("comments")
        .add({
      "username": currentUserModel.username,
      "comment": comment,
      "timestamp": Timestamp.now(),
      "avatarUrl": currentUserModel.photoUrl,
      "userId": currentUserModel.id
    });

    // Adds to postOwner's activity feed
    Firestore.instance
        .collection("insta_a_feed")
        .document(postOwner)
        .collection("items")
        .add({
      "username": currentUserModel.username,
      "userId": currentUserModel.id,
      "type": "comment",
      "userProfileImg": currentUserModel.photoUrl,
      "commentData": comment,
      "timestamp": Timestamp.now(),
      "postId": postId,
      "mediaUrl": postMediaUrl,
    });

    // Add comment to the current listview for an optimistic update.
    setState(() {
      fetchedComments = List.from(fetchedComments)..add(Comment(
        username: currentUserModel.username,
        comment: comment,
        timestamp: Timestamp.now(),
        avatarUrl: currentUserModel.photoUrl,
        userId: currentUserModel.id,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: buildPage(),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;

  Comment(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});

  factory Comment.fromDocument(DocumentSnapshot document) {
    return Comment(
      username: document['username'],
      userId: document['userId'],
      comment: document["comment"],
      timestamp: document["timestamp"],
      avatarUrl: document["avatarUrl"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(avatarUrl),
          ),
        ),
        Divider(),
      ],
    );
  }
}
