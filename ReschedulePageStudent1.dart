
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/pages/PostScreenPage.dart';
import 'package:fast_access/pages/ProfilePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class Student extends StatefulWidget {
  String Course1 ;
  String Course1timing ;
  Student({
    this.Course1,
    this.Course1timing,
  });
  @override
  StudentState createState() => StudentState();
}

class StudentState extends State<Student> {
  create()
  {
    ListTile(
      title: GestureDetector(
        //onTap: ()=> displayUserProfile(context, userProfileID: UserID),
        child: RichText(
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
              style: TextStyle(fontSize: 14.0, color: Colors.indigo),
              children: [
                TextSpan(text: 'Course: ' + widget.Course1, style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: '\nTiming: ' + widget.Course1timing),
                //TextSpan(text: '\nStartTime: $StartTime'),
                //TextSpan(text: '\nEndTime: $EndTime'),
              ]
          ),
        ),
      ),
      // leading: CircleAvatar(
      //   backgroundImage: CachedNetworkImageProvider(SenderPic),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          create(),
        ],
      ),
    );

  }

}