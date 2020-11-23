import 'dart:convert';
import 'dart:io';

import 'package:Fluttergram/component/image_post.dart';
import 'package:Fluttergram/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin<Feed> {
  List<ImagePost> feedData;

  Widget buildFeed() {
    if (feedData != null) {
      return ListView(
        children: feedData,
      );
    } else {
      return Container(
        alignment: FractionalOffset.center,
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    this._loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fluttergram",
            style: TextStyle(
                fontFamily: "Billabong", color: Colors.black, fontSize: 35.0)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: buildFeed(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Future<Null> _refresh() async {
    await _getFeed();

    setState(() {});

    return;
  }

  _loadFeed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString("feed");

    if (json != null) {
      List<Map<String, dynamic>> data =
          jsonDecode(json).cast<Map<String, dynamic>>();
      List<ImagePost> listOfPosts = _generateFeed(data);

      setState(() {
        feedData = listOfPosts;
      });
    } else {
      _getFeed();
    }
  }

  _generateFeed(List<Map<String, dynamic>> feedData) {
    List<ImagePost> listOfPosts = [];

    for (var postData in feedData) {
      listOfPosts.add(ImagePost.fromJSON(postData));
    }
  }

  _getFeed() async {
    print("Starting get Feed");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = googleSignIn.currentUser.id.toString();
    String url =
        'https://us-central1-mp-rps.cloudfunctions.net/getFeed?uid=' + userId;
    HttpClient httpClient = HttpClient();

    List<ImagePost> listOfPosts;
    String result;
    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        String json = await response.transform(utf8.decoder).join();
        prefs.setString("feed", json);

        List<Map<String, dynamic>> data =
            jsonDecode(json).cast<Map<String, dynamic>>();
        listOfPosts = _generateFeed(data);

        result = "Success in http request for feed";
      } else {
        result =
            "Error getting a feed: Http status ${response.statusCode} | userId $userId";
      }
    } catch (exception) {
      result = "Failed invoking the getFeed function. Exception: $exception";
    }

    print(result);

    setState(() {
      feedData = listOfPosts;
    });
  }
}
