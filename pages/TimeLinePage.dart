import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/HeaderWidget.dart';
import 'package:buddiesgram/widgets/PostWidget.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TimeLinePage extends StatefulWidget {
  final User gCurrentUser;

  TimeLinePage({
    this.gCurrentUser
});
  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  List<Post> posts;
  List<String> followingsLists= [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  retrieveTimeline() async {
    QuerySnapshot querySnapshot = await timelineReference.document(widget.gCurrentUser.id).collection("TimelinePosts").orderBy("Timestamp", descending: true).getDocuments();
    List<Post> allPosts =  querySnapshot.documents.map((document) => Post.fromDocument(document)).toList();

    setState(() {
      this.posts = allPosts;
    });
  }

  retrieveFollowings() async {
    QuerySnapshot querySnapshot = await followingReference.document(currentUser.id).collection("UserFollowing").getDocuments();

    setState(() {
      followingsLists = querySnapshot.documents.map((document) => document.documentID).toList();
    });
  }

  @override
  void initState()
  {
    super.initState();
    retrieveTimeline();
    retrieveFollowings();
  }

  createTimeline(){
    if(posts == null)
      {
        return circularProgress();
      }
    else
      {
        return ListView(
          children: posts,
        );
      }
  }

  @override
  Widget build(context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, sTitle: "Announcement Feed"),
      body: RefreshIndicator(
        child: createTimeline(), onRefresh: () => retrieveTimeline(),
      ),
    );
  }
}
