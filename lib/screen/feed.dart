import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feed extends StatefulWidget {
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> with AutomaticKeepAliveClientMixin<Feed> {
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
      listOfPosts.add(ImagePost.fromJson(postData));
    }
  }

  @override
  void initState() {
    super.initState();
    this._loadFeed();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  bool get wantKeepAlive => true;
}
