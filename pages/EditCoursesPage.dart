import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:sqflite/sqflite.dart';
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

  updateCoursesData(){
    usersReference.document(widget.currentOnlineUserID).updateData({
      "subject1" : Course1,
      "subject2" : Course2,
      "subject3" : Course3,
      "subject4" : Course4,
      "subject5" : Course5,
    });

    SnackBar snackBar = SnackBar(content: Text("Courses has been Updated Successfully."));
    _scaffoldGlobalKey.currentState.showSnackBar(snackBar);
  }

  String dropdownValue1 = 'Course1';
  String dropdownValue2 = 'Course2';
  String dropdownValue3 = 'Course3';
  String dropdownValue4 = 'Course4';
  String dropdownValue5 = 'Course5';
  String Course1;
  String Course2;
  String Course3;
  String Course4;
  String Course5;
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
          Center(
            child:
            DropdownButton<String>(
              value: dropdownValue1,
              icon: Icon(Icons.arrow_downward),
              iconSize: 34,
              elevation: 16,
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.tealAccent, fontSize: 30),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue1 = newValue;
                  Course1 = newValue;
                });
              },
              items: <String>['Course1', 'Database Systems', 'Operating Systems', 'Algorithms', 'Marketing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Center(
            child: DropdownButton<String>(
              value: dropdownValue2,
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
                  dropdownValue2 = newValue;
                  Course2 = newValue;
                });
              },
              items: <String>['Course2', 'Database Systems', 'Operating Systems', 'Algorithms', 'Marketing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

          ),

          Center(
            child: DropdownButton<String>(
              value: dropdownValue3,
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
                  dropdownValue3 = newValue;
                  Course3 = newValue;
                });
              },
              items: <String>['Course3', 'Database Systems', 'Operating Systems', 'Algorithms', 'Marketing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

          ),

          Center(
            child: DropdownButton<String>(
              value: dropdownValue4,
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
                  dropdownValue4 = newValue;
                  Course4 = newValue;
                });
              },
              items: <String>['Course4', 'Database Systems', 'Operating Systems', 'Algorithms', 'Marketing']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

          ),
          Center(
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
