import 'dart:io';

import 'package:Fluttergram/screen/feed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/my_user.dart';
import 'screen/create_account.dart';

final auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();
final ref = Firestore.instance.collection('insta_users');
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

MyUser currentUserModel;

Future<void> main() async {
  // After upgrading flutter this is now necessary
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Fluttergram());
}

Future<void> tryCreateUserRecord(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    return null;
  }

  DocumentSnapshot userRecord = await ref.document(user.id).get();
  // User record not exists, Time to create!
  if (userRecord.data == null) {
    String userName = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Center(
                  child: Scaffold(
                    appBar: AppBar(
                      leading: Container(),
                      title: Text(
                        'Fill out missing data',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    body: ListView(
                      children: <Widget>[
                        Container(
                          child: CreateAccount(),
                        )
                      ],
                    ),
                  ),
                )));

    if (userName != null || userName.length != 0) {
      ref.document(user.id).setData({
        "id": user.id,
        "username": userName,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "bio": "",
        "followers": {},
        "following": {},
      });
    }
    userRecord = await ref.document(user.id).get();
  }

  currentUserModel = MyUser.fromDocument(userRecord);
  return null;
}

Future<Null> _ensureLoggedIn(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    await googleSignIn.signIn();
  }
  await tryCreateUserRecord(context);
}

Future<Null> _silentLogin(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;

  if (user == null) {
    user = await googleSignIn.signInSilently();
    await tryCreateUserRecord(context);
  }

  if (await auth.currentUser() == null && user != null) {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

    await auth.signInWithCredential(credential);
  }
}

Future<Null> _setUpNotifications() async {
  if (Platform.isAndroid) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  _firebaseMessaging.getToken().then((token) {
    print("Firebase Messaging Token: " + token);

    Firestore.instance
        .collection("insta_users")
        .document(currentUserModel.id)
        .updateData({"androidNotificationToken": token});
  });
}

class Fluttergram extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttergram',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          buttonColor: Colors.pink,
          primaryIconTheme: IconThemeData(color: Colors.black)),
      home: HomePage(title: 'Fluttergram'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool triedSilentLogin = false;
  bool setupNotifications = false;
  int _page = 0;

  PageController pageController;

  Scaffold buildLoginPage() {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 240.0),
          child: Column(
            children: <Widget>[
              Text(
                'Fluttergram',
                style: TextStyle(
                    fontSize: 60.0,
                    fontFamily: "Billabong",
                    color: Colors.black),
              ),
              Padding(padding: EdgeInsets.only(bottom: 100.0)),
              GestureDetector(
                child: Image.asset(
                  "assets/images/google_signin_button.png",
                  width: 225.0,
                ),
                onTap: login,
              )
            ],
          ),
        ),
      ),
    );
  }

  void silentLogin(BuildContext context) async {
    await _silentLogin(context);
    setState(() {
      triedSilentLogin = true;
    });
  }

  void login() async {
    await _ensureLoggedIn(context);
    setState(() {
      triedSilentLogin = true;
    });
  }

  void setUpNotifications() {
    _setUpNotifications();
    setState(() {
      setupNotifications = true;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  void navigationTapped(int page) {
    // Animation page
    pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (triedSilentLogin == false) {
      silentLogin(context);
    }

    if (setupNotifications == false && currentUserModel != null) {
      setUpNotifications();
    }

    return (googleSignIn.currentUser == null || currentUserModel == null
        ? buildLoginPage()
        : Scaffold(
            body: PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: onPageChanged,
              children: [
                Container(
                  color: Colors.white,
                  child: Feed(),
                ),
                Container(color: Colors.white,
                // child: SearchPage(),
                ),
                Container(
                  color: Colors.white,
                  // child: Uploader(),
                ),
                Container(
                  color: Colors.white,
                  // child: ProfilePage(
                  //   userId: googleSignIn.currentUser.id,
                  // ),
                )
              ],
            ),
            bottomNavigationBar: CupertinoTabBar(
              onTap: navigationTapped,
              currentIndex: _page,
              backgroundColor: Colors.white,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      color: _page == 0 ? Colors.black : Colors.grey,
                    ),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.search,
                      color: _page == 1 ? Colors.black : Colors.grey,
                    ),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.add_circle,
                      color: _page == 2 ? Colors.black : Colors.grey,
                    ),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.star,
                      color: _page == 3 ? Colors.black : Colors.grey,
                    ),
                    backgroundColor: Colors.white),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      color: _page == 4 ? Colors.black : Colors.grey,
                    ),
                    backgroundColor: Colors.white),
              ],
            ),
          ));
  }
}
