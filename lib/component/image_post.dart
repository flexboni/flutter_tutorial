import 'dart:async';

import 'package:Fluttergram/main.dart';
import 'package:Fluttergram/screen/comment_screen.dart';
import 'package:Fluttergram/screen/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePost extends StatefulWidget {
  final String mediaUrl;
  final String username;
  final String location;
  final String description;
  final likes;
  final String postId;
  final String ownerId;

  ImagePost(
      {this.mediaUrl,
      this.username,
      this.location,
      this.description,
      this.likes,
      this.postId,
      this.ownerId});

  factory ImagePost.fromDocument(DocumentSnapshot document) {
    return ImagePost(
      mediaUrl: document['mediaUrl'],
      username: document['username'],
      location: document['location'],
      description: document['description'],
      likes: document['likes'],
      postId: document['postId'],
      ownerId: document['ownerId'],
    );
  }

  factory ImagePost.fromJSON(Map data) {
    return ImagePost(
      mediaUrl: data['mediaUrl'],
      username: data['username'],
      location: data['location'],
      description: data['description'],
      likes: data['likes'],
      postId: data['postId'],
      ownerId: data['ownerId'],
    );
  }

  @override
  _ImagePostState createState() => _ImagePostState(
        mediaUrl: this.mediaUrl,
        username: this.username,
        location: this.location,
        description: this.description,
        likes: this.likes,
        postId: this.postId,
        ownerId: this.ownerId,
      );
}

class _ImagePostState extends State<ImagePost> {
  final String mediaUrl;
  final String username;
  final String location;
  final String description;
  Map likes;
  final String postId;
  final String ownerId;
  bool liked;
  var reference = Firestore.instance.collection('insta_posts');
  int likeCount;
  bool showHeart = false;

  final TextStyle boldStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  _ImagePostState(
      {this.mediaUrl,
      this.username,
      this.location,
      this.description,
      this.likes,
      this.postId,
      this.ownerId});

  Widget buildPostHeader({String ownerId}) {
    if (ownerId == null) {
      return Text("owner error");
    }

    return FutureBuilder(
        future: Firestore.instance
            .collection('insta_users')
            .document(ownerId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    CachedNetworkImageProvider(snapshot.data.data['photoUrl']),
                backgroundColor: Colors.grey,
              ),
              title: GestureDetector(
                  onTap: () {
                    openProfile(context, ownerId);
                  },
                  child: Text(
                    snapshot.data.data['username'],
                    style: boldStyle,
                  )),
              subtitle: Text(location),
              trailing: Icon(Icons.more_vert),
            );
          } else {
            return Container();
          }
        });
  }

  GestureDetector buildLikeableImage() {
    return GestureDetector(
      onDoubleTap: () => _likedPost(postId),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: mediaUrl,
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => loadingPlaceHolder,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          showHeart
              ? Positioned(
                  child: Container(
                      width: 100,
                      height: 100,
                      child: Opacity(
                        opacity: 0.85,
                        child: FlareActor(
                          "assets/flare/Like.flr",
                          animation: "Like",
                        ),
                      )))
              : Container()
        ],
      ),
    );
  }

  Container loadingPlaceHolder = Container(
    height: 400.0,
    child: Center(child: CircularProgressIndicator()),
  );

  GestureDetector buildLikeIcon() {
    Color color;
    IconData icon;

    if (liked) {
      color = Colors.pink;
      icon = FontAwesomeIcons.solidHeart;
    } else {
      icon = FontAwesomeIcons.heart;
    }

    return GestureDetector(
      child: Icon(
        icon,
        size: 25.0,
        color: color,
      ),
      onTap: () {
        _likedPost(postId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    liked = likes[googleSignIn.currentUser.id.toString()] == true;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        buildPostHeader(ownerId: ownerId),
        buildLikeableImage(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: 20.0, top: 40.0)),
            buildLikeIcon(),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
            GestureDetector(
              child: Icon(
                FontAwesomeIcons.comment,
                size: 25.0,
              ),
              onTap: () {
                goToComments(
                    context: context,
                    postId: postId,
                    ownerId: ownerId,
                    mediaUrl: mediaUrl);
              },
            ),
          ],
        )
      ],
    );
  }

  void _likedPost(String postId2) {
    var userId = googleSignIn.currentUser.id;
    bool _liked = likes[userId] == true;

    if (_liked) {
      print('removing list');
      reference.document(postId).updateData({
        'likes.$userId': false
        // firestore plugin doesn't support deleting, so it must be nulled or falsed.
      });

      setState(() {
        --likeCount;
        liked = false;
        likes[userId] = false;
      });

      removeActivityFeedItem();
    } else {
      print('liking');
      reference.document(postId).updateData({'likes.$userId': true});

      addActivityFeedItem();

      setState(() {
        ++likeCount;
        liked = true;
        likes[userId] = true;
        showHeart = true;
      });

      Timer(const Duration(milliseconds: 2000), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  void removeActivityFeedItem() {
    Firestore.instance
        .collection("insta_a_feed")
        .document(ownerId)
        .collection("items")
        .document(postId)
        .delete();
  }

  void addActivityFeedItem() {
    Firestore.instance
        .collection("insta_a_feed")
        .document(ownerId)
        .collection("items")
        .document(postId)
        .setData({
      "username": currentUserModel.username,
      "userId": currentUserModel.id,
      "type": "like",
      "userProfileImg": currentUserModel.photoUrl,
      "mediaUrl": mediaUrl,
      "timestamp": DateTime.now(),
      "postId": postId,
    });
  }

  void goToComments(
      {BuildContext context, String postId, String ownerId, String mediaUrl}) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return CommentScreen(
          postId: postId, postOwner: ownerId, postMediaUrl: mediaUrl);
    }));
  }
}
