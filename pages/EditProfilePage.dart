import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class EditProfilePage extends StatefulWidget {
  final String currentOnlineUserID;
  EditProfilePage({
    this.currentOnlineUserID
});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  TextEditingController profileNametextEditingController = TextEditingController();
  TextEditingController biotextEditingController = TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  User user;
  bool _bioValid = true;
  bool _profileNameValid = true;

  void initState(){
    super.initState();
    getandDisplay();
  }

  getandDisplay() async {
    setState(() {
      loading = true;
    });

    DocumentSnapshot documentSnapshot = await usersReference.document(widget.currentOnlineUserID).get();
    user = User.fromDocument(documentSnapshot);
    profileNametextEditingController.text = user.profileName;
    biotextEditingController.text = user.bio;

    setState(() {
      loading = false;
    });
  }

  updateUserData(){
    setState(() {
      profileNametextEditingController.text.trim().length < 3 || profileNametextEditingController.text.isEmpty ? _profileNameValid = false : _profileNameValid = true;
      biotextEditingController.text.trim().length > 20 ? _bioValid = false : _bioValid = true;
    });

    if(_bioValid && _profileNameValid){ 
      usersReference.document(widget.currentOnlineUserID).updateData({
        "profileName": profileNametextEditingController.text,
        "bio": biotextEditingController.text,
      });

      SnackBar snackBar = SnackBar(content: Text("Profile has been Updated Successfully."));
      _scaffoldGlobalKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit Profile", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon: Icon(Icons.done, color: Colors.white, size: 30.0,), onPressed: ()=> Navigator.pop(context),),
        ],
      ),
      body: loading ? circularProgress() : ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                child: CircleAvatar(
                  radius: 52.0,
                  backgroundImage: CachedNetworkImageProvider(user.url),
                ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      createProfileNameTextFormField(), createBioTextFormField(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 29.0, left: 50.0, right: 50.0),
                  child: RaisedButton(
                    onPressed: updateUserData,
                    child: Text(
                      "Update", style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                  child: RaisedButton(
                    color: Colors.red,
                    onPressed: logoutUser,
                    child: Text(
                      "Logout", style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  logoutUser() async {
    await gSignIn.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));

  }

  Column createProfileNameTextFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 13.0),
        child: Text(
          "Profile Name", style: TextStyle(color: Colors.grey),
        ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: profileNametextEditingController,
          decoration: InputDecoration(
            hintText: "Write Profile Name Here...",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _profileNameValid ? null : "Profile Name is Very Short!"
          ),
        ),
      ],
    );
  }

  Column createBioTextFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio", style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: biotextEditingController,
          decoration: InputDecoration(
              hintText: "Write Bio Here...",
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey
                  ),
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintStyle: TextStyle(color: Colors.grey),
              errorText: _bioValid ? null : "Bio is Very Long!"
          ),
        ),
      ],
    );
  }
}
