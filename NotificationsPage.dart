import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/pages/PostScreenPage.dart';
import 'package:fast_access/pages/ProfilePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int totalnoofstudents;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, sTitle: "Notifications"),
      body: Container(
        child: FutureBuilder(
          future: retrieveNotifications(),
          builder: (context, dataSnapShot)
          {
            if(!dataSnapShot.hasData)
              {
                return circularProgress();
              }
            //print("herfffppppppppppppppppppppppppppp");
            return ListView(children: dataSnapShot.data,);
          },
        ),
      ),
    );
  }

  retrieveNotifications() async {
    QuerySnapshot querySnapshot = await activityFeedReference.document(currentUser.id).
    collection("FeedItems").orderBy("Timestamp", descending: true).limit(60).getDocuments();

    // totalnoofstudents = querySnapshot.size;
    // print("tt: $totalnoofstudents");

    List<NotificationsItem> notificationsItem = [];
    querySnapshot.documents.forEach((document) {
      notificationsItem.add(NotificationsItem.fromDocument(document));

      //print("herffddddddddddddddf");
    });
    //print("herffeeeeeeeeeeeeeeeeef");
    return notificationsItem;

  }
}

String notificationItemText;
Widget mediaPreview;

class NotificationsItem extends StatelessWidget {
  final String Username;
  final String Type;
  final String CommentData;
  final String PostID;
  final String UserID;
  final String UserProfileIMG;
  final String URL;
  final Timestamp timestamp;

  NotificationsItem({this.Username, this.Type, this.CommentData, this.PostID, this.UserID, this.UserProfileIMG, this.URL, this.timestamp});

  factory NotificationsItem.fromDocument(DocumentSnapshot documentSnapshot){
    //print("herfff");
    return NotificationsItem(
      Username: documentSnapshot["Username"],
      Type: documentSnapshot["Type"],
      CommentData: documentSnapshot["CommentData"],
      PostID: documentSnapshot["PostID"],
      UserID: documentSnapshot["UserID"],
      UserProfileIMG: documentSnapshot["UserProfileIMG"],
      URL: documentSnapshot["URL"],
      timestamp: documentSnapshot["Timestamp"],
    );
  }


  @override
  Widget build(BuildContext context) {

    configureMediaPreview(context);
    //print("herre");

    return Padding(
        padding: EdgeInsets.only(bottom: 2.0),
        child: Container(
          color: Colors.white12,
          child: ListTile(
            title: GestureDetector(
              onTap: ()=> displayUserProfile(context, userProfileID: UserID),
              child: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: Colors.blue),
                  children: [
                    TextSpan(text: Username, style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " $notificationItemText"),
                  ]
                ),
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(UserProfileIMG),
            ),
            //subtitle: Text(tAgo.format(timestamp.toDate()), overflow: TextOverflow.ellipsis,),
            trailing: mediaPreview,
          ),
        ),
    );
  }
  displayUserProfile(BuildContext context, {String userProfileID}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userProfileID: userProfileID)));
  }

  configureMediaPreview(context) {
    if(Type == "Comment" || Type == "Like")
      {
        mediaPreview = GestureDetector(
          onTap: ()=> displayFullPost(context),
          child: Container(
            height: 50.0,
            width: 50.0,
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: CachedNetworkImageProvider(URL)),
                ),
              ),
            ),
          ),
        );
      }
    else
      {
        mediaPreview = Text("");
    }

    if(Type == "Like")
      {
        notificationItemText = "Liked your Post.";
      }

    else if(Type == "Comment")
    {
      notificationItemText = "Replied: $CommentData";
    }

    else if(Type == "Follow")
    {
      notificationItemText = "is now a connection.";
    }

    else
      {
        notificationItemText = "Error, Unknown type = $Type";
      }
  }
  displayFullPost(context){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> PostScreenPage(PostID: PostID, UserID: UserID,)));
  }
}
