import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
import 'package:buddiesgram/pages/DB.dart';
import 'dart:async';

class EditCoursesPage extends StatefulWidget {
  final String currentOnlineUserID;
  EditCoursesPage({
    this.currentOnlineUserID
  });

  @override
  _EditCoursesPageState createState() => _EditCoursesPageState();
}

class _EditCoursesPageState extends State<EditCoursesPage> {
  List<DropdownMenuItem<String>> list;
  bool loading = false;
  User user;

  updateCoursesData() async {
    print("in here");

    /*print(user.subject1);
    print(user.subject2);
    print(user.subject3);
    print(user.subject4);
    print(user.subject5);
    print("hellllllllllll");*/
    if(Course1 == null)
      {
        Course1 = user.subject1;
        print("in here1");
      }
    if(Course2 == null)
    {
      Course2 = user.subject2;
      print("in here2");
    }
    if(Course3 == null)
    {
      Course3 = user.subject3;
      print("in here3");
    }
    if(Course4 == null)
    {
      Course4 = user.subject4;
      print("in here4");
    }
    if(Course5 == null)
    {
      Course5 = user.subject5;
      print("in here5");
    }
    usersReference.document(widget.currentOnlineUserID).updateData({
      "subject1" : Course1,
      "subject2" : Course2,
      "subject3" : Course3,
      "subject4" : Course4,
      "subject5" : Course5,
      "timing1" : Timing1,
      "room1" : Room1,
      "timing2" : Timing2,
      "room2" : Room2,
      "timing3" : Timing3,
      "room3" : Room3,
      "timing4" : Timing4,
      "room4" : Room4,
      "timing5" : Timing5,
      "room5" : Room5,
    });

    SnackBar snackBar = SnackBar(content: Text("Courses has been Updated Successfully."));
    _scaffoldGlobalKey.currentState.showSnackBar(snackBar);
  }

  String dropdownValue1;
  String dropdownValue2;
  String dropdownValue3;
  String dropdownValue4;
  String dropdownValue5;
  String Course1;
  String Course2;
  String Course3;
  String Course4;
  String Course5;
  String Timing1;
  String Timing2;
  String Timing3;
  String Timing4;
  String Timing5;
  String Room1;
  String Room2;
  String Room3;
  String Room4;
  String Room5;
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      key: _scaffoldGlobalKey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Edit Courses", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(icon: Icon(Icons.done, color: Colors.white, size: 30.0,), onPressed: ()=> Navigator.pop(context),),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("d").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
                {
                  Text("Loading");
                }
              else
                {
                  List<DropdownMenuItem> items = [];
                  for(int i=0; i<snapshot.data.documents.length; i++){
                    DocumentSnapshot snap = snapshot.data.documents[i];
                    items.add(
                      DropdownMenuItem(
                          child: Text(
                            snap.documentID,
                            style: TextStyle(color: Colors.teal),
                          ),
                        value: "${snap.documentID}",
                      )
                    );
                  }
                  return Center(
                    child: DropdownButton(
                      value: dropdownValue1,
                      items: items,
                      hint: new Text("Course1", style: TextStyle(color: Colors.tealAccent),),
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 34,
                      elevation: 16,
                      dropdownColor: Colors.black,
                      style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                      underline: Container(
                        alignment: Alignment.center,
                        height: 2,
                        color: Colors.limeAccent,
                      ),
                      onChanged: (value) {

                        setState(() {
                          Firestore.instance.collection("d").document(value).get().then((value){
                            Timing1 = value.data["Timing"];
                            Room1 = value.data["Room"];
                          });
                          dropdownValue1 = value;
                          Course1 = value;
                        });
                      },
                    ),

                  );
                }
            },
          ),


          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("d").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
              {
                Text("Loading");
              }
              else
              {
                List<DropdownMenuItem> items = [];
                for(int i=0; i<snapshot.data.documents.length; i++){
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  items.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Colors.teal),
                        ),
                        value: "${snap.documentID}",
                      )
                  );
                }
                return Center(
                  child: DropdownButton(
                    value: dropdownValue2,
                    items: items,
                    hint: new Text("Course2", style: TextStyle(color: Colors.tealAccent),),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 34,
                    elevation: 16,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                    underline: Container(
                      alignment: Alignment.center,
                      height: 2,
                      color: Colors.limeAccent,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Firestore.instance.collection("d").document(value).get().then((value){
                          Timing2 = value.data["Timing"];
                          Room2 = value.data["Room"];
                        });
                        dropdownValue2 = value;
                        Course2 = value;
                      });
                    },
                  ),

                );
              }
            },
          ),


          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("d").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
              {
                Text("Loading");
              }
              else
              {
                List<DropdownMenuItem> items = [];
                for(int i=0; i<snapshot.data.documents.length; i++){
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  items.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Colors.teal),
                        ),
                        value: "${snap.documentID}",
                      )
                  );
                }
                return Center(
                  child: DropdownButton(
                    value: dropdownValue3,
                    items: items,
                    hint: new Text("Course3", style: TextStyle(color: Colors.tealAccent),),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 34,
                    elevation: 16,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                    underline: Container(
                      alignment: Alignment.center,
                      height: 2,
                      color: Colors.limeAccent,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Firestore.instance.collection("d").document(value).get().then((value){
                          Timing3 = value.data["Timing"];
                          Room3 = value.data["Room"];
                        });
                        dropdownValue3 = value;
                        Course3 = value;
                      });
                    },
                  ),

                );
              }
            },
          ),

          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("d").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
              {
                Text("Loading");
              }
              else
              {
                List<DropdownMenuItem> items = [];
                for(int i=0; i<snapshot.data.documents.length; i++){
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  items.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Colors.teal),
                        ),
                        value: "${snap.documentID}",
                      )
                  );
                }
                return Center(
                  child: DropdownButton(
                    value: dropdownValue4,
                    items: items,
                    hint: new Text("Course4", style: TextStyle(color: Colors.tealAccent),),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 34,
                    elevation: 16,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                    underline: Container(
                      alignment: Alignment.center,
                      height: 2,
                      color: Colors.limeAccent,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Firestore.instance.collection("d").document(value).get().then((value){
                          Timing4 = value.data["Timing"];
                          Room4 = value.data["Room"];
                        });
                        dropdownValue4 = value;
                        Course4 = value;
                      });
                    },
                  ),

                );
              }
            },
          ),

          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("d").snapshots(),
            builder: (context,snapshot){
              if(!snapshot.hasData)
              {
                Text("Loading");
              }
              else
              {
                List<DropdownMenuItem> items = [];
                for(int i=0; i<snapshot.data.documents.length; i++){
                  DocumentSnapshot snap = snapshot.data.documents[i];
                  items.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.documentID,
                          style: TextStyle(color: Colors.teal),
                        ),
                        value: "${snap.documentID}",
                      )
                  );
                }
                return Center(
                  child: DropdownButton(
                    value: dropdownValue5,
                    items: items,
                    hint: new Text("Course5", style: TextStyle(color: Colors.tealAccent),),
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 34,
                    elevation: 16,
                    dropdownColor: Colors.black,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 20),
                    underline: Container(
                      alignment: Alignment.center,
                      height: 2,
                      color: Colors.limeAccent,
                    ),
                    onChanged: (value) {
                      setState(() {
                        Firestore.instance.collection("d").document(value).get().then((value){
                          Timing5 = value.data["Timing"];
                          Room5 = value.data["Room"];
                        });
                        dropdownValue5 = value;
                        Course5 = value;
                      });
                    },
                  ),

                );
              }
            },
          ),


          Padding(
            padding: EdgeInsets.only(top: 29.0, left: 50.0, right: 50.0),
            child: RaisedButton(
              onPressed: updateCoursesData,
              child: Text(
                "Update", style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ),



        ],
      ),
    );

  }

}

/*Center(
            child: DropdownButton<String>(
              value: dropdownValue5,
              icon: Icon(Icons.arrow_downward),
              iconSize: 34,
              elevation: 16,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.tealAccent, fontSize: 30),
              underline: Container(
                alignment: Alignment.center,
                height: 2,
                color: Colors.limeAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue5 = newValue;
                  Course5 = newValue;
                });
              },
              items: <String>['Course5', 'Database Systems', 'Operating Systems', 'Algorithms', 'Marketing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

          ),*/