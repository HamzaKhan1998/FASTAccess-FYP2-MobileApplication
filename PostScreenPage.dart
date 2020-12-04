import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/PostWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:flutter/material.dart';

class PostScreenPage extends StatelessWidget {
  final String PostID;
  final String UserID;

  PostScreenPage({
    this.UserID,
    this.PostID
});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: postsReference.document(UserID).collection("UserPosts").document(PostID).get(),
        builder: (context, dataSnapShot)
        {
          if(!dataSnapShot.hasData)
            {
              return circularProgress();
            }

          Post post = Post.fromDocument(dataSnapShot.data);
          return Center(
            child: Scaffold(
              appBar: header(context, strTitle: post.Description),
              body: ListView(
                children: <Widget>[
                  Container(
                    child: post,
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}