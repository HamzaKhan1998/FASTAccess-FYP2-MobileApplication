import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/EditCoursesPage.dart';
import 'package:buddiesgram/pages/EditProfilePage.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/HeaderWidget.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'AppointmentPage.dart';



class ProfilePage extends StatefulWidget {

  final String userProfileID;
  ProfilePage({this.userProfileID});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentOnlineUserID = currentUser?.id;
  int ctf, ctff =0;
  bool following = false;


  /*void startdb() async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection('d').getDocuments();
    User user = User.fromDocument(dataSnapShot.data);

    querySnapshot.documents.forEach((document) {
      if(document.documentID == user.subject1 || document.documentID == user.subject1 || document.documentID == user.subject1 || document.documentID == user.subject1 )
    });
  }*/

  void initState(){
    getAllFollowers();
    getAllFollowing();
    checkIfAlreadyFollowing();
  }
  getAllFollowers() async {
    QuerySnapshot querySnapshot = await followersReference.document(widget.userProfileID).
    collection("UserFollowers").getDocuments();

    setState(() {
      ctf = querySnapshot.documents.length;
    });
  }

  getAllFollowing() async {
    QuerySnapshot querySnapshot = await followingReference.document(widget.userProfileID).
    collection("UserFollowing").getDocuments();

    setState(() {
      ctff = querySnapshot.documents.length;
    });
  }

  checkIfAlreadyFollowing() async {
    DocumentSnapshot documentSnapshot = await followersReference.
    document(widget.userProfileID).collection("UserFollowers").document(currentOnlineUserID).get();

    setState(() {
      following = documentSnapshot.exists;
    });
  }


  createProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfileID).get(),
      builder: (context, dataSnapShot){
        if(!dataSnapShot.hasData)
        {
          return circularProgress();
            }


        User user = User.fromDocument(dataSnapShot.data);
        //print(dataSnapShot.data);
        DateTime date = DateTime.now();
        //print("weekday is ${date.weekday}");
        //print(date.weekday.runtimeType);

        return Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: CachedNetworkImageProvider(user.url),
                  ),

                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        /*Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            createColumns("Posts", 0),
                            createColumns("Followers", ctf),
                            createColumns("Following", ctff),
                          ],
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            createButton()
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            createButton1()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 5.0),

                child: Text(
                  user.profileName, style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 3.0, bottom:4),
                child: Text(
                  user.bio, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              /*Container(
                child: Text.rich(
                  buildStatus("Status", date.weekday),
                ),
              ),*/
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.brown),
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Schedule", style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer1(user.subject1, user.day1, user.day11, user.room1, user.room11, user.timing1, user.timing11, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer2(user.subject2, user.day2, user.day22, user.room2, user.room22, user.timing2, user.timing22, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer3(user.subject3, user.day3, user.day33, user.room3, user.room33, user.timing3, user.timing33, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer4(user.subject4, user.day4, user.day44, user.room4, user.room44, user.timing4, user.timing44, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer5(user.subject5, user.day5, user.day55, user.room5, user.room55, user.timing5, user.timing55, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
        },
    );
  }

  TextSpan buildStatus(String S, int day){

  }

  TextSpan buildContainer(String s1, String t1, String r1){
    return TextSpan(
      children: [
        TextSpan(text: s1),
        TextSpan(text: '\n$t1'),
        TextSpan(text: '\n$r1'),
      ],
    );
  }

  TextSpan buildContainer1(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
      {
        return TextSpan(
          children: [
            TextSpan(text: s1),
            TextSpan(text: '\n$t1'),
            TextSpan(text: '\n$r1'),
          ],
        );
      }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer2(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer3(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer4(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer5(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  Column createColumns(String title, int count){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString(), style: TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  createButton(){
    bool ownprofile = currentOnlineUserID == widget.userProfileID;
    if(ownprofile){
      return createButtonTitleandFunction(title: "Edit Profile", performFunction: editUserProfile,);
    }
    else if(following){
      return createButtonTitleandFunction(title: "Unfollow", performFunction: controlUnfollowUser,);
    }
    else if(!following){
      return createButtonTitleandFunction(title: "Follow", performFunction: controlFollowUser,);
    }
  }

  createButton1(){
    bool ownprofile = currentOnlineUserID == widget.userProfileID;
    if(ownprofile){
      return createButtonTitleandFunction1(title: "Edit Courses", performFunction: editCourses,);
    }
    else {
      return createButtonTitleandFunction1(title: "Book Appointment", performFunction: bookAppointment,);
    }
  }

  controlUnfollowUser(){
    setState(() {
      following = false;
    });
    followersReference.document(widget.userProfileID).collection("UserFollowers").
    document(currentOnlineUserID).get().then((document) {
      if(document.exists)
        {
          document.reference.delete();
        }
    });

    followingReference.document(currentOnlineUserID).collection("UserFollowing").
    document(widget.userProfileID).get().then((document) {
      if(document.exists)
      {
        document.reference.delete();
      }
    });

    activityFeedReference.document(widget.userProfileID).collection("FeedItems").
    document(currentOnlineUserID).get().then((document) {
      if(document.exists)
        {
          document.reference.delete();
        }
    });
  }

  controlFollowUser(){
    setState(() {
      following = true;
    });

    followersReference.document(widget.userProfileID)
    .collection("UserFollowers").document(currentOnlineUserID).setData({});

    followingReference.document(currentOnlineUserID)
        .collection("UserFollowing").document(widget.userProfileID).setData({});

    activityFeedReference.document(widget.userProfileID)
    .collection("FeedItems").document(currentOnlineUserID).setData({
      "Type": "Follow",
      "OwnerID": widget.userProfileID,
      "Username": currentUser.username,
      "Timestamp": DateTime.now(),
      "UserProfileIMG": currentUser.url,
      "UserID": currentOnlineUserID,
    });

  }





  Container createButtonTitleandFunction({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 225.0,
          height: 26.0,
          child: Text(title, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  Container createButtonTitleandFunction1({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 225.0,
          height: 26.0,
          child: Text(title, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }
  
  editUserProfile(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(currentOnlineUserID: currentOnlineUserID)));
  }

  editCourses(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCoursesPage(currentOnlineUserID: currentOnlineUserID)));
  }

  bookAppointment(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentPage(currentOnlineUserID: currentOnlineUserID, userProfileID: widget.userProfileID)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, sTitle: "Profile"),
      body: ListView(
        children: <Widget>[
          createProfileTopView(),
        ],
      ),
    );
  }
}
