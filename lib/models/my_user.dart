import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String email;
  final String id;
  final String photoUrl;
  final String username;
  final String displayName;
  final String bio;
  final Map followers;
  final Map following;

  const MyUser(
      {this.username,
      this.id,
      this.photoUrl,
      this.email,
      this.displayName,
      this.bio,
      this.followers,
      this.following});

  factory MyUser.fromDocument(DocumentSnapshot document) {
    return MyUser(
      username: document['username'],
      id: document['id'],
      photoUrl: document['photoUrl'],
      email: document['email'],
      displayName: document['displayName'],
      bio: document['bio'],
      followers: document['followers'],
      following: document['following'],
    );
  }
}
