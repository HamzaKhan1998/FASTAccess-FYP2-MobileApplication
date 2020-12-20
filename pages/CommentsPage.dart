import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;

class CommentsPage extends StatefulWidget {
  final String PostID;
  final String PostOwnerID;
  final String PostImageURL;

  CommentsPage({
   this.PostID, this.PostOwnerID, this.PostImageURL
});
  @override
  CommentsPageState createState() => CommentsPageState(PostID: PostID, PostOwnerID: PostOwnerID, PostImageURL: PostImageURL);
}

class CommentsPageState extends State<CommentsPage> {

  final String PostID;
  final String PostOwnerID;
  final String PostImageURL;
  TextEditingController commentTextEditingController = TextEditingController();
  CommentsPageState ({
    this.PostID, this.PostOwnerID, this.PostImageURL
});

  retrieveComments()
  {
    return StreamBuilder(
      stream: commentsReference.document(PostID).collection("Comments").orderBy("Timestamp", descending: false).snapshots(),
      builder: (context, dataSnapshot){
        if(!dataSnapshot.hasData)
          {
            return circularProgress();
          }
        List<Comment> comments = [];
        dataSnapshot.data.documents.forEach((document){
          comments.add(Comment.fromDocument(document));
        });
        return ListView(
          children: comments,
        );
      },
    );
  }

  saveComment(){
    commentsReference.document(PostID).collection("Comments").add({
      "ProfileName": currentUser.profileName,
      "UserID": currentUser.id,
      "Comment": commentTextEditingController.text,
      "URL": currentUser.url,
      "Timestamp": DateTime.now(),
    });

    bool isNotPostOwner = currentUser.id != PostOwnerID;

    if(isNotPostOwner){
      activityFeedReference.document(PostOwnerID).collection("FeedItems").add({
        "Type": "comment",
        "CommentData": commentTextEditingController.text,
        "PostID": PostID,
        "UserID": currentUser.id,
        "ProfileName": currentUser.profileName,
        "UserProfileImg": currentUser.url,
        "URL": PostImageURL,
        "Timestamp": DateTime.now()
      });
    }
    commentTextEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, strTitle: "Comments"),
      body: Column(
        children: <Widget>[
          Expanded(child: retrieveComments(),),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentTextEditingController,
              decoration: InputDecoration(
                  labelText: "Write your comment here...",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
              ),
              style: TextStyle(color: Colors.white),
            ),
            trailing: OutlineButton(
              onPressed: saveComment,
              borderSide: BorderSide.none,
              child: Text("Publish", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {

  final String ProfileName;
  final String UserID;
  final String URL;
  final String comment;
  final Timestamp timestamp ;

  Comment({
   this.ProfileName, this.UserID, this.URL, this.comment, this.timestamp
});

  factory Comment.fromDocument(DocumentSnapshot documentSnapshot){
    return Comment(
      ProfileName: documentSnapshot["ProfileName"],
      UserID: documentSnapshot["UserID"],
      comment: documentSnapshot["comment"],
      URL: documentSnapshot["URL"],
      timestamp: documentSnapshot["Timestamp"],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(ProfileName + ":   " + comment, style: TextStyle(fontSize: 18.0, color: Colors.black)),
              leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(URL)),
              subtitle: Text(tAgo.format(timestamp.toDate()), style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    );
  }
}
