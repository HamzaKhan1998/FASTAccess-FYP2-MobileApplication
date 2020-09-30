import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/pages/ProfilePage.dart';
import 'package:buddiesgram/widgets/CImageWidget.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String PostID;
  final String OwnerID;
  //final String Timestamp;
  final dynamic Likes;
  final String Username;
  final String Description;
  final String Location;
  final String URL;

  Post({
    this.PostID,
    this.OwnerID,
    //this.Timestamp,
    this.Likes,
    this.Username,
    this.Description,
    this.Location,
    this.URL,
});

  factory Post.fromDocument(DocumentSnapshot documentSnapshot){
    return Post(
      PostID: documentSnapshot["PostID"],
      OwnerID: documentSnapshot["OwnerID"],
      Likes: documentSnapshot["Likes"],
      Username: documentSnapshot["Username"],
      Description: documentSnapshot["Description"],
      Location: documentSnapshot["Location"],
      URL: documentSnapshot["URL"],
    );
  }

  int getTotalNumberOfLokes(Likes){
    if(Likes == null)
      {
        return 0;
      }

    int counter = 0;
    Likes.values.forEach((eachValue){
      if(eachValue == true)
        {
          counter = counter + 1;
        }
    });
    return counter;
  }

  @override
  _PostState createState() => _PostState(
    PostID: this.PostID,
    OwnerID: this.OwnerID,
    Likes: this.Likes,
    Username: this.Username,
    Description: this.Description,
    Location: this.Location,
    URL: this.URL,
    LikesCount: getTotalNumberOfLokes(this.Likes),
  );
}


class _PostState extends State<Post> {
  final String PostID;
  final String OwnerID;
  //final String Timestamp;
  Map Likes;
  final String Username;
  final String Description;
  final String Location;
  final String URL;
  int LikesCount;
  bool isLiked;
  bool showHeart = false;
  final String currentOnlineUserID = currentUser?.id;

  _PostState({
    this.PostID,
    this.OwnerID,
    //this.Timestamp,
    this.Likes,
    this.Username,
    this.Description,
    this.Location,
    this.URL,
    this.LikesCount,
  });

  createPostHead(){
    return FutureBuilder(
        future: usersReference.document(OwnerID).get(),
        builder: (context, dataSnapshot){
          if(!dataSnapshot.hasData)
          {
            return circularProgress();
          }
          User user = User.fromDocument(dataSnapshot.data);
          bool isPostOwner = currentOnlineUserID == OwnerID;
          return ListTile(
            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(user.url),backgroundColor: Colors.grey,),
            title: GestureDetector(
              onTap: ()=> displayUserProfile(context, userProfileID: user.id),
              child: Text(
                user.username,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            subtitle: Text(Location, style: TextStyle(color: Colors.white),),
            trailing: isPostOwner ? IconButton(
                icon: Icon(Icons.more_vert, color: Colors.white,),
                onPressed: ()=> print("Deleted"),
          ) : Text(""),
          );
        },
    );

  }

  displayUserProfile(BuildContext context, {String userProfileID}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userProfileID: userProfileID)));
  }

  createPostPicture(){
    return GestureDetector(
      onDoubleTap: ()=> print("Post Liked"),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          cachedNetworkImage(URL)
        ],
      ),
    );

  }

  createPostFooter(){
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 40.0, left: 20.0)
            ),
            GestureDetector(
              onTap: ()=> print("Post Liked"),
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28.0,
                color: Colors.pink,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0)
            ),
            GestureDetector(
              onTap: ()=> print("Show Comments"),
              child: Icon(
                Icons.chat_bubble_outline, size: 28.0, color: Colors.white,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$LikesCount Likes",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text("$Username ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            ),
            Expanded(
                child: Text(Description, style: TextStyle(color: Colors.white),),
            ),
          ],
        )
      ],
    );

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          createPostHead(),
          createPostPicture(),
          createPostFooter(),
        ],
      ),
    );
  }
}
