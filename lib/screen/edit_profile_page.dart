import 'package:Fluttergram/main.dart';
import 'package:Fluttergram/models/my_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  Column buildTextField({String name, TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(hintText: name),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firestore.instance
          .collection('insta_users')
          .document(currentUserModel.id)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: FractionalOffset.center,
            child: CircularProgressIndicator(),
          );
        }

        MyUser user = MyUser.fromDocument(snapshot.data);
        nameController.text = user.displayName;
        bioController.text = user.displayName;

        return Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(currentUserModel.photoUrl),
                radius: 50.0,
              ),
            ),
            FlatButton(
                onPressed: () {
                  changeProfilePhoto(context);
                },
                child: Text(
                  "Change Photo",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  buildTextField(name: "Name", controller: nameController),
                  buildTextField(name: "Bio", controller: bioController),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: MaterialButton(
                onPressed: () => _logout(context),
                child: Text("Logout"),
              ),
            )
          ],
        );
      },
    );
  }

  changeProfilePhoto(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Change Photo'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Changing your profile photo has not been implemented yet')
                ],
              ),
            ),
          );
        });
  }

  void _logout(BuildContext context) async {
    print('logout');

    await auth.signOut();
    await googleSignIn.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    currentUserModel = null;

    Navigator.pop(context);
  }

  void applyChanges() {
    Firestore.instance
        .collection('insta_users')
        .document(currentUserModel.id)
        .updateData({
      "displayName": nameController.text,
      "bio": bioController.text,
    });
  }
}
