import 'dart:math';

import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/EditCoursesPage.dart';
import 'package:buddiesgram/pages/EditProfilePage.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/HeaderWidget.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class AppointmentPage extends StatefulWidget {
  final String currentOnlineUserID;
  final String userProfileID;
  AppointmentPage({
    this.currentOnlineUserID,
    this.userProfileID
  });
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  String AppointmentID = Uuid().v4();
  DateTime dateTime = DateTime.now();
  String date;
  TimeOfDay timeOfDay = TimeOfDay.now();
  String time;
  TextEditingController descriptiontextEditingController = TextEditingController();
  TextEditingController subjecttextEditingController = TextEditingController();

  saveAppointmentInfoToFirestore() {
    //print("hello");
    appointmentReference.document(widget.currentOnlineUserID).collection(
        "UserAppointments").document(AppointmentID).setData({
      "DateofAppointment": date,
      "TimeofAppointment": time,
      "AppointmentID": AppointmentID,
      "AppointmentMadeTo": widget.userProfileID,
      "AppointmentMadeFrom": widget.currentOnlineUserID,
      "AppointmentSubject": subjecttextEditingController.text,
      "AppointmentDescription": descriptiontextEditingController.text,
    });
    Navigator.pop(context);
    }

    Future<Null> SelectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(context: context,
          initialDate: dateTime,
          firstDate: DateTime(2019),
          lastDate: DateTime(2021));
      if (picked != null && picked != dateTime) {

        setState(() {
          dateTime = picked;
          date = DateFormat('yyyy/MM/dd').format(dateTime);
          //print(date);
        });
      }
    }

    Future<Null> SelectTime(BuildContext context) async {
      final TimeOfDay picked = await showTimePicker(
          context: context, initialTime: timeOfDay);
      if (picked != null && picked != timeOfDay) {

        setState(() {
          timeOfDay = picked;
          time = timeOfDay.toString();
          //print(time);
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Book Appointment", style: TextStyle(color: Colors.white),),
          actions: [
            //IconButton(icon: Icon(Icons.done, color: Colors.white, size: 30.0,),
              //onPressed: ()=> saveAppointmentInfoToFirestore(),),
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              //leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.gCurrentUser.url ),),
              title: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: subjecttextEditingController,
                  decoration: InputDecoration(
                    hintText: "Subject...",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            //Divider(),
            ListTile(
              //leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
              title: Container(
                width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: descriptiontextEditingController,
                  decoration: InputDecoration(
                    hintText: "Description...",
                    hintStyle: TextStyle(color: Colors.white38),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Select Date of Appointment"),
                  onPressed: () {
                    SelectDate(context);
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("Select Time of Appointment"),
                  onPressed: () {
                    SelectTime(context);
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                ),
                Divider(),
                Divider(),
                RaisedButton(
                  child: Text("Send Appointment Request"),
                  onPressed: ()=> saveAppointmentInfoToFirestore(),
                  color: Colors.red,
                  padding: EdgeInsets.all(10.0),
                ),
              ],
            ),

          ],
        ),

      );
    }
  }
