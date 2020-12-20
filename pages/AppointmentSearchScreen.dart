import 'dart:async';

import 'package:fast_access/models/user.dart';

import 'package:fast_access/pages/HomePage.dart';

import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'AppointmentViewPersonSchedule.dart';

class AppointmentSearchPage extends StatefulWidget {

//   AppointmentSearchPage({
//     this.participants,
// });
  @override
  _AppointmentSearchPageState createState() => _AppointmentSearchPageState();
}

class _AppointmentSearchPageState extends State<AppointmentSearchPage> with AutomaticKeepAliveClientMixin<AppointmentSearchPage>{
  TextEditingController searchTextEditingControl = TextEditingController();
  //String participants;
  Future<QuerySnapshot> futureSearchResults;
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  List participants = [];

  emptyTheTextFormField(){
    searchTextEditingControl.clear();
  }

  controlSearching(String str){
    Future<QuerySnapshot> allUsers = usersReference.where("profileName", isGreaterThanOrEqualTo: str).getDocuments();
    setState(() {
      futureSearchResults = allUsers;
    });
  }

  pop()
  {
    // print("part");
    // print(participants);
    Navigator.pop(context, participants);
  }

  AppBar searchPageHeader(){
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: pop),
      backgroundColor: Colors.black,
      title: TextFormField(
        style: TextStyle(fontSize: 18.0, color: Colors.white),
        controller: searchTextEditingControl,
        decoration: InputDecoration(
          hintText: "Search Here...",
          hintStyle: TextStyle(color: Colors.grey),
          // enabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey),
          // ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.white),
          // ),
          // filled: true,
          // prefixIcon: Icon(Icons.person_pin, color: Colors.white, size: 30.0,),
          suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: emptyTheTextFormField(),),
        ),
        onFieldSubmitted: controlSearching,
      ),
    );
  }

  Container displayNoSearchResultScreen(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(

          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.group, color: Colors.grey, size: 200.0,),
            Text(
              "Add Participants for Meeting",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 52.0),
            ),
          ],
        ),
      ),
    );
  }

  gotoAppointmentPerson(Userr userr)
  {
    DateTime dateTime = DateTime.now();
    int now = dateTime.weekday;
    if(now == userr.day1)
      {

      }
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentPerson(userr: userr,)));
  }

  displayUserProfile(BuildContext context, {String userProfileID}){
    participants.add(userProfileID);
    return showDialog(
        context: context,
        // ignore: missing_return
        builder: (context){
          Timer(Duration(seconds: 2), (){
            Navigator.pop(context);
          });
          return AlertDialog(
            title: Text("Participant Added!", style: TextStyle(color: Colors.tealAccent), textAlign: TextAlign.center,),
            backgroundColor: Colors.white10,

            // actions: <Widget>[
            //   MaterialButton(
            //     child: Text("Proceed"),
            //     onPressed: ()
            //     {
            //       Navigator.pop(context);
            //     },
            //
            //   ),
            // ],
          );
        }
    );
    //Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(gCurrentUser: gCurrentUser, userProfileID: userProfileID, userProfilePic: currentUser.url, userProfileUsername: currentUser.profileName,)));
  }

  display(String pn, String id, String url, Userr userr){
    return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white54,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onLongPress: () => gotoAppointmentPerson(userr),
              onTap: () => displayUserProfile(context, userProfileID: id,),
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.black, backgroundImage: CachedNetworkImageProvider(url),),
                title: Text(pn, style: TextStyle(
                  color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold,
                ),),
                // subtitle: Text(eachUser.username, style: TextStyle(
                //   color: Colors.black, fontSize: 13.0,
                // ),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  displayUsersFoundScreen() {
    return FutureBuilder(
      future: futureSearchResults,
      builder: (context, dataSnapshot) {
        if (!dataSnapshot.hasData) {
          return circularProgress();
        }

        List<Padding> searchUserResult = [];
        dataSnapshot.data.documents.forEach((document) {
          Userr eachUser = Userr.fromDocument(document);
          Padding padding = display(eachUser.profileName, eachUser.id, eachUser.url, eachUser);
          searchUserResult.add(padding);
        });
        return ListView(children: searchUserResult);
      },
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldGlobalKey,
      backgroundColor: Colors.black,
      appBar: searchPageHeader(),
      body: futureSearchResults == null ? displayNoSearchResultScreen() : displayUsersFoundScreen(),
    );
  }
}



