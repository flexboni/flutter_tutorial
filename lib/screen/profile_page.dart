import 'package:Fluttergram/component/image_post.dart';
import 'package:Fluttergram/main.dart';
import 'package:Fluttergram/models/my_user.dart';
import 'package:Fluttergram/screen/edit_profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState(this.userId);
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  final String profileId;

  String currentUserId = googleSignIn.currentUser.id;
  bool followButtonClicked = false;
  bool isFollowing = false;
  int postCount = 0;
  String view = "grid"; // default view

  _ProfilePageState(this.profileId);

  Column buildStateColumn(String label, int number) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(number.toString(),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }

  Container buildProfileFollowButton(MyUser user) {
    // Viewing your own profile - should show edit button
    if (currentUserId == profileId) {
      return buildFollowingButton(
          text: "Edit Profile",
          backgroundColor: Colors.white,
          textColor: Colors.black,
          borderColor: Colors.grey,
          function: editProfile);
    }

    // Already following user - should show unfollow button.
    if (isFollowing) {
      return buildFollowingButton(
        text: "Unfollow",
        backgroundColor: Colors.white,
        textColor: Colors.black,
        borderColor: Colors.grey,
        function: unfollowUser,
      );
    }

    // does not follow user - should show follow button.
    if (!isFollowing) {
      return buildFollowingButton(
        text: "Follow",
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        borderColor: Colors.blue,
        function: followUser,
      );
    }

    return buildFollowingButton(
      text: "loading...",
      backgroundColor: Colors.white,
      textColor: Colors.black,
      borderColor: Colors.grey,
    );
  }

  Container buildFollowingButton(
      {String text,
      Color backgroundColor,
      Color textColor,
      Color borderColor,
      Function function}) {
    return Container(
        padding: EdgeInsets.only(top: 2.0),
        child: FlatButton(
            onPressed: function,
            child: Container(
              decoration: BoxDecoration(
                  color: backgroundColor,
                  border: Border.all(color: borderColor),
                  borderRadius: BorderRadius.circular(5.0)),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
              width: 250.0,
              height: 27.0,
            )));
  }

  Row buildImageViewButtonBar() {
    Color isActiveButtonColor(String viewName) {
      if (view == viewName) {
        return Colors.blueAccent;
      } else {
        return Colors.black26;
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_on),
          color: isActiveButtonColor("grid"),
          onPressed: () {
            changeView("grid");
          },
        ),
        IconButton(
          icon: Icon(Icons.list),
          color: isActiveButtonColor("feed"),
          onPressed: () {
            changeView("feed");
          },
        ),
      ],
    );
  }

  Container buildUserPosts() {
    Future<List<ImagePost>> getPosts() async {
      List<ImagePost> posts = [];
      var snap = await Firestore.instance
          .collection('insta_posts')
          .where('ownerId', isEqualTo: profileId)
          .orderBy('timestamp')
          .getDocuments();

      for (var doc in snap.documents) {
        posts.add(ImagePost.fromDocument(doc));
      }

      setState(() {
        postCount = snap.documents.length;
      });

      return posts.reversed.toList();
    }

    return Container(
      child: FutureBuilder<List<ImagePost>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: FractionalOffset.center,
                  padding: EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator());

              // build the grid.
            } else if (view == "grid") {
              return GridView.count(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 1.5,
                  crossAxisSpacing: 1.5,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: snapshot.data.map((ImagePost imagePost) {
                    return GridTile(child: ImageTile(imagePost));
                  }).toList());

            } else if (view == "feed") {
              return Column(
                children: snapshot.data.map((ImagePost imagePost) {
                  return imagePost;
                }).toList(),
              );
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // reload state when opend again.

    return StreamBuilder(
        stream: Firestore.instance
            .collection("insta_users")
            .document(profileId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(),
            );
          }

          MyUser user = MyUser.fromDocument(snapshot.data);

          if (user.followers.containsKey(currentUserId) &&
              user.followers[currentUserId] &&
              followButtonClicked == false) {
            isFollowing = true;
          }

          return Scaffold(
              appBar: AppBar(
                title: Text(
                  user.username,
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
              body: ListView(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        CircleAvatar(
                          radius: 40.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: NetworkImage(user.photoUrl),
                        ),
                        Expanded(
                            flex: 1,
                            child: Column(children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  buildStateColumn("post", postCount),
                                  buildStateColumn(
                                      "post", _countFollowings(user.followers)),
                                  buildStateColumn(
                                      "post", _countFollowings(user.following)),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    buildProfileFollowButton(user),
                                  ])
                            ]))
                      ]),
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(top: 15.0),
                          child: Text(
                            user.displayName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 1.0),
                        child: Text(user.bio),
                      )
                    ])),
                Divider(),
                buildImageViewButtonBar(),
                Divider(
                  height: 0.0,
                ),
                buildUserPosts(),
              ]));
        });
  }

  @override
  bool get wantKeepAlive => true;

  void changeView(String viewName) {
    setState(() {
      view = viewName;
    });
  }

  int _countFollowings(Map followings) {
    int count = 0;

    void countValue(key, value) {
      if (value) count += 1;
    }

    followings.forEach(countValue);

    return count;
  }

  void editProfile() {
    EditProfilePage editPage = EditProfilePage();

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Center(
        child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.maybePop(context);
                },
              ),
              title: Text(
                'Edit Profile',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      editPage.applyChanges();
                      Navigator.maybePop(context);
                    })
              ]),
          body: ListView(
            children: <Widget>[
              Container(
                child: editPage,
              )
            ],
          ),
        ),
      );
    }));
  }

  void unfollowUser() {
    print('unfollowing user');
    setState(() {
      isFollowing = false;
      followButtonClicked = true;
    });

    Firestore.instance.document("insta_users/$profileId").updateData({
      'followers.$currentUserId': false
      // firestore plugin doesn't support deletin, so it must be nulled / falsed.
    });

    Firestore.instance.document("insta_users/$currentUserId").updateData({
      'followers.$profileId': false
      // firestore plugin doesn't support deletin, so it must be nulled / falsed.
    });

    Firestore.instance
        .collection("insta_a_feed")
        .document(profileId)
        .collection("item")
        .document(currentUserId)
        .delete();
  }

  void followUser() {
    print('following user');

    setState(() {
      isFollowing = true;
      followButtonClicked = true;
    });

    Firestore.instance.document("insta_users/$profileId").updateData({
      'followers.$currentUserId': true
      // firestore plugin doesn't support deletin, so it must be nulled / falsed.
    });

    Firestore.instance.document("insta_users/$currentUserId").updateData({
      'followers.$profileId': true
      // firestore plugin doesn't support deletin, so it must be nulled / falsed.
    });

    Firestore.instance
        .collection("insta_a_feed")
        .document(profileId)
        .collection("item")
        .document(currentUserId)
        .setData({
      "ownerId": profileId,
      "username": currentUserModel.username,
      "userId": currentUserId,
      "type": "follow",
      "userProfileImg": currentUserModel.photoUrl,
      "timestamp": DateTime.now()
    });
  }
}

void openProfile(BuildContext context, String userId) {
  Navigator.of(context)
      .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
    return ProfilePage(
      userId: userId,
    );
  }));
}

class ImageTile extends StatelessWidget {
  final ImagePost imagePost;

  ImageTile(this.imagePost);

  void clickedImage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<bool>(builder: (BuildContext context) {
      return Center(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Photo',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
          ),
          body: ListView(
            children: <Widget>[Container(child: imagePost)],
          ),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => clickedImage(context),
        child: Image.network(imagePost.mediaUrl, fit: BoxFit.cover));
  }
}
