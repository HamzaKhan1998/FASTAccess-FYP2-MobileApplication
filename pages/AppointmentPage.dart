import 'dart:math';

import 'package:fast_access/models/user.dart';
import 'package:fast_access/pages/AppointmentSearchScreen.dart';
import 'package:fast_access/pages/CalenderPage.dart';
import 'package:fast_access/pages/EditCoursesPage.dart';
import 'package:fast_access/pages/EditProfilePage.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/pages/projector_icons.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fast_access/pages/CalenderClient.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class AppointmentPage extends StatefulWidget {
  final Userr gCurrentUser;
  final String currentOnlineUserID;
  final String SenderPic;
  final String Username;
  AppointmentPage({
    this.gCurrentUser,
    this.currentOnlineUserID,
    this.SenderPic,
    this.Username,
  });

  insert()
  {

  }
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {

  String dropdownValue1;
  String Course1;
  TextEditingController locationtextEditingController = TextEditingController();
  String AppointmentID = Uuid().v4();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(days: 1));
  // String date;
  // TimeOfDay timeOfDay = TimeOfDay.now();
  // String time;
  TextEditingController descriptiontextEditingController = TextEditingController();
  TextEditingController subjecttextEditingController = TextEditingController();
  TextEditingController participantstextEditingController = TextEditingController();
  TextEditingController resourcetextEditingController = TextEditingController();
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  CalendarClient calendarClient = CalendarClient();
  List participants = [];
  bool check = true;



  saveAppointmentInfoToFirestore() {
     // print("Helooooooooo ");
     // print(widget.Username);
    participants.forEach((element) {
      print("in 1");
      print("Ele: $element");
      appointmentReference1.document(widget.currentOnlineUserID).collection(
          "UserAppointments").document(AppointmentID).setData({
        "StartTimeofAppointment": startTime,
        "EndTimeofAppointment": endTime,
        "AppointmentID": AppointmentID,
        "AppointmentMadeTo": element,
        "Venue": locationtextEditingController.text,
        "AppointmentMadeFrom": widget.currentOnlineUserID,
        "AppointmentSubject": subjecttextEditingController.text,
        "AppointmentDescription": descriptiontextEditingController.text,
        "SenderPic": widget.SenderPic,
        "NameofAppointmentRequester": widget.Username,
      });
    });

    participants.forEach((element) {
      print("Ele: $element");
      appointmentReference2.document(element).collection(
          "UserAppointments").document(AppointmentID).setData({
        "StartTimeofAppointment": startTime,
        "EndTimeofAppointment": endTime,
        "AppointmentID": AppointmentID,
        "Venue": locationtextEditingController.text,
        "AppointmentMadeTo": element,
        "AppointmentMadeFrom": widget.currentOnlineUserID,
        "AppointmentSubject": subjecttextEditingController.text,
        "AppointmentDescription": descriptiontextEditingController.text,
        "SenderPic": widget.SenderPic,
        "NameofAppointmentRequester": widget.Username,
      });
    });

    RoomReference.doc(dropdownValue1).collection("Meetings").doc(Uuid().v4()).set({
      "StartTimeofAppointment": startTime,
      "EndTimeofAppointment": endTime,
      "AppointmentMadeFrom": widget.Username,
    });

    AdminReference.doc(Uuid().v4()).set({
      "StartTimeofAppointment": startTime,
      "EndTimeofAppointment": endTime,
      "Resources": resourcetextEditingController.text,
      "AppointmentMadeFrom": widget.Username,
      "SenderPic": widget.SenderPic,
      "Venue": locationtextEditingController.text,
    });



    SnackBar snackBar = SnackBar(content: Text("Your Appointment has been sent Successfully."));
    _scaffoldGlobalKey.currentState.showSnackBar(snackBar);
    calendarClient.insert(
      subjecttextEditingController.text,
      startTime,
      endTime,
    );
    //Navigator.pop(context);
    }

    toAppointmentSearchPage () async
    {
       final PList = await Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentSearchPage()));

       List list = [];
       DocumentSnapshot documentSnapshot;
       participants = PList;
       print("parti: $participants");
       QuerySnapshot querySnapshot = await usersReference.getDocuments();
       // print("length: ");
       // print(querySnapshot.docs.length);
       querySnapshot.documents.forEach((element) {

         // print("Element: ");
         // print(element.id);
         if(participants.contains(element.id))
           {
             list.add(element.data()["profileName"]);
             // print("Name: ");
             // print(element.data()["profileName"]);
           }

       });

       //print("List: $s");
       String s = list.toString();
       participantstextEditingController.text = s;
    }




    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: _scaffoldGlobalKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Book Appointment", style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(icon: Icon(Icons.done, color: Colors.white, size: 30.0,), onPressed: ()=> Navigator.pop(context),),
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              //leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.gCurrentUser.url ),),
              title: Container(
                //width: 150.0,
                child: TextField(
                  style: TextStyle(color: Colors.blue),
                  controller: subjecttextEditingController,
                  decoration: InputDecoration(
                    hintText: "Subject...",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Divider(thickness: 1, color: Colors.grey,),
            ListTile(
              //leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
              title: Container(
                //width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.blue),
                  controller: descriptiontextEditingController,
                  decoration: InputDecoration(
                    hintText: "Description...",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Divider(thickness: 1, color: Colors.grey,),

            ListTile(
              //leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
              title: Container(
                //width: 250.0,
                child: TextFormField(
                  style: TextStyle(color: Colors.blue),
                  controller: participantstextEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add Participants...",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    //suffixIcon: IconButton(icon: Icon(Icons.clear, color: Colors.white,), onPressed: emptyTheTextFormField(),),
                  ),
                  onTap: ()=> toAppointmentSearchPage(),
                  //onFieldSubmitted: controlSearching,
                ),
              ),
            ),
            //searchPageHeader(),

            Divider(thickness: 1, color: Colors.grey,),

            CheckboxListTile(
              title: Text("Projector"),
              secondary: Icon(Projector.projector),
              controlAffinity: ListTileControlAffinity.trailing,
              value: timeDilation != 1.0,
              onChanged: (bool value){
                setState(() {
                  timeDilation = value ? 2.0 : 1.0;
                });
              },
              activeColor: Colors.white60,
              checkColor: Colors.blue,
            ),

            ListTile(
              //leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
              title: Container(
                //width: 250.0,
                child: TextField(
                  style: TextStyle(color: Colors.blue),
                  controller: resourcetextEditingController,
                  decoration: InputDecoration(
                    hintText: "Resources needed if any...",
                    hintStyle: TextStyle(color: Colors.blueGrey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            Divider(thickness: 1, color: Colors.grey,),

            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Select Start-Time of Appointment"),
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2020, 3, 5),
                        maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            this.startTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                ),
                Text('$startTime', style: TextStyle(color: Colors.grey),),
                RaisedButton(
                  child: Text("Select End-Time of Appointment"),
                  onPressed: () {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2020, 3, 5),
                        maxTime: DateTime(2022, 6, 7), onChanged: (date) {
                          print('change $date');
                        }, onConfirm: (date) {
                          setState(() {
                            this.endTime = date;
                          });
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  color: Colors.white,
                  padding: EdgeInsets.all(10.0),
                ),
                Text('$endTime', style: TextStyle(color: Colors.grey),),
                Divider(),
                Divider(),
                // SizedBox(
                //   width: 10,
                //   child: Text("See Schedule", style: TextStyle(color: Colors.yellowAccent),),
                // ),
                Center(
                  child: DropdownButton<String>(
                    value: dropdownValue1,
                    hint: new Text("Select Venue from List", style: TextStyle(color: Colors.tealAccent, fontSize: 18.0), textAlign: TextAlign.center,),
                    icon: Icon(Icons.arrow_drop_down_outlined),
                    iconSize: 40,
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
                        dropdownValue1 = newValue;
                        Course1 = newValue;
                        locationtextEditingController.text = newValue;
                      });
                    },
                    items: <String>['Meeting Room', 'C-301', 'C-302', 'C-303', 'C-304', 'C-305', 'C-306', 'C-307', 'C-308', 'C-309']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Center(
                          child: Text(value, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                        ),
                      );
                    }).toList(),
                  ),

                ),
                RaisedButton(
                  child: Text("See Schedule"),
                  onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderPage(gCurrentUser: widget.gCurrentUser,))),
                  color: Colors.tealAccent,
                  padding: EdgeInsets.all(10.0),
                ),
                //Divider(),
                //Divider(),
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



// Future<Null> SelectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(context: context,
//       initialDate: dateTime,
//       firstDate: DateTime(2019),
//       lastDate: DateTime(2021));
//   if (picked != null && picked != dateTime) {
//
//     setState(() {
//       dateTime = picked;
//       date = DateFormat('yyyy/MM/dd').format(dateTime);
//       //print(date);
//     });
//   }
// }
//
// Future<Null> SelectTime(BuildContext context) async {
//   final TimeOfDay picked = await showTimePicker(
//       context: context, initialTime: timeOfDay);
//   if (picked != null && picked != timeOfDay) {
//
//     setState(() {
//       timeOfDay = picked;
//       time = timeOfDay.toString();
//       //print(time);
//     });
//   }
// }