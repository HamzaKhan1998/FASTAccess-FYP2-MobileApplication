import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/EditCoursesPage.dart';
import 'package:buddiesgram/pages/EditProfilePage.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/HeaderWidget.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';



class ProfilePage extends StatefulWidget {

  final String userProfileID;
  ProfilePage({this.userProfileID});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String currentOnlineUserID = currentUser?.id;


  createProfileTopView(){
    return FutureBuilder(
      future: usersReference.document(widget.userProfileID).get(),
      builder: (context, dataSnapShot){
        if(!dataSnapShot.hasData)
        {
          return circularProgress();
            }
        User user = User.fromDocument(dataSnapShot.data);
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
                            createColumns("Followers", 0),
                            createColumns("Following", 0),
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
                padding: EdgeInsets.only(top: 3.0),
                child: Text(
                  user.bio, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  "Schedule", style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.subject1, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.subject2, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.subject3, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.subject4, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  user.subject5, style: TextStyle(fontSize: 18.0, color: Colors.white70),
                ),
              ),
            ],
          ),
        );
        },
    );
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
  }

  createButton1(){
    bool ownprofile = currentOnlineUserID == widget.userProfileID;
    if(ownprofile){
      return createButtonTitleandFunction1(title: "Edit Courses", performFunction: editCourses,);
    }
  }

  Container createButtonTitleandFunction({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 245.0,
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



  Subjects(){
    return showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Subjects", style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("OOP (1-A) ", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                onPressed: subject1,
              ),
              SimpleDialogOption(
                child: Text("DLD (1-A) ", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                onPressed: subject2,
              ),
              SimpleDialogOption(
                child: Text("OOP (1-B) ", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                onPressed: subject3,
              ),
            ],
          );
        }
    );
  }

  subject1(){

  }

  subject2(){

  }

  subject3(){

  }

  Container createButtonTitleandFunction1({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 245.0,
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
