import 'package:fast_access/pages/AppointmentDetailScreen.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fast_access/widgets/MiniAppointmentCard.dart';
import 'package:fast_access/widgets/AppointmentCard.dart';
import 'package:fast_access/widgets/SlidingCard.dart';
import 'package:fast_access/Logic/AppointmentManager.dart';
import 'package:page_transition/page_transition.dart';
import 'package:fast_access/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fast_access/models/user.dart';
import 'package:fast_access/pages/EditCoursesPage.dart';
import 'package:fast_access/pages/EditProfilePage.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/PostTileWidget.dart';
import 'package:fast_access/widgets/PostWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentScreen2 extends StatefulWidget {
  // final String userProfileID;
  // AppointmentScreen2({this.userProfileID});
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen2> {

  int tnoa;

  @override
  void initState() {
    super.initState();
    //initializeappointments();

  }

  initializeappointments() async {
    //print("hwllllllllllllllllllllll");
    QuerySnapshot querySnapshot = await appointmentReference2.document(currentUser?.id).
    collection("UserAppointments").getDocuments();

    tnoa = querySnapshot.documents.length;
    //print("ynoa: $tnoa");
    //print(widget.userProfileID);

    List<AppointmentItem> appointmentItem = [];
    querySnapshot.documents.forEach((document) {
      appointmentItem.add(AppointmentItem.fromDocument(document));

    });

    return appointmentItem;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, sTitle: "Appointments"),
      body: Container(
        child: FutureBuilder(
          future: initializeappointments(),
          builder: (context, dataSnapShot)
          {
            if(!dataSnapShot.hasData)
            {
              return circularProgress();
            }
            return ListView(children: dataSnapShot.data,);
          },
        ),
      ),
    );
  }
}

class AppointmentItem extends StatelessWidget{
  final DateTime StartTimeofAppointment;
  final DateTime EndTimeofAppointment;
  final String AppointmentID;
  final String AppointmentMadeTo;
  final String AppointmentMadeFrom;
  final String AppointmentSubject;
  final String AppointmentDescription;
  final String SenderPic;
  final String NameofAppointmentRequester;
  final String Venue;

  bool isFirstTime = false;
  bool isLoading = true;
  List<Widget> topHeader;
  List<Widget> currentAppointment= new List<Widget>();
  List<Widget> midHeader;
  List<Widget> futureAppointment;
  List<Widget> finalList;

  AppointmentItem({
    this.StartTimeofAppointment,
    this.EndTimeofAppointment,
    this.AppointmentID,
    this.AppointmentMadeTo,
    this.AppointmentMadeFrom,
    this.AppointmentSubject,
    this.AppointmentDescription,
    this.SenderPic,
    this.NameofAppointmentRequester,
    this.Venue
  });

  factory AppointmentItem.fromDocument(DocumentSnapshot documentSnapshot){
    //print("in here");
    return AppointmentItem(
      StartTimeofAppointment: documentSnapshot["StartTimeofAppointment"].toDate(),
      EndTimeofAppointment: documentSnapshot["EndTimeofAppointment"].toDate(),
      AppointmentID: documentSnapshot["AppointmentID"],
      AppointmentMadeTo: documentSnapshot["AppointmentMadeTo"],
      AppointmentMadeFrom: documentSnapshot["AppointmentMadeFrom"],
      AppointmentSubject: documentSnapshot["AppointmentSubject"],
      AppointmentDescription: documentSnapshot["AppointmentDescription"],
      SenderPic: documentSnapshot["SenderPic"],
      NameofAppointmentRequester: documentSnapshot["NameofAppointmentRequester"],
      Venue: documentSnapshot["Venue"],
    );
  }

  @override
  void initState() {
    //super.initState();

    //AppointmentManager.generateAppointmentList();
  }

  @override
  Widget build(BuildContext context) {
    //print('in scafffold');
    SlidingCardController aController = new SlidingCardController();
    SizeConfig().init(context);
    String convertedDateTime1 = "${StartTimeofAppointment.year.toString()}-${StartTimeofAppointment.month.toString().padLeft(2,'0')}-${StartTimeofAppointment.day.toString().padLeft(2,'0')} ${StartTimeofAppointment.hour.toString()}:${StartTimeofAppointment.minute.toString()}";
    String convertedDateTime2 = "${EndTimeofAppointment.year.toString()}-${EndTimeofAppointment.month.toString().padLeft(2,'0')}-${EndTimeofAppointment.day.toString().padLeft(2,'0')} ${EndTimeofAppointment.hour.toString()}:${EndTimeofAppointment.minute.toString()}";
    //print("here");
    //print(convertedDateTime);
    return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AppointmentCard(
            onCardTapped: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: AppointmentDetailScreen(
                    DOA: convertedDateTime1,
                    TOA: convertedDateTime2,
                    SenderPic: SenderPic,
                    NameofAppointmentRequester: NameofAppointmentRequester,
                    AppointmentSubject: AppointmentSubject,

                  ),
                ),
              );
            },
            key: Key(Random().nextInt(4000).toString()),
            slidingCardController: aController,
            DOA: convertedDateTime1,
            TOA: convertedDateTime2,
            SenderPic: SenderPic,
            NameofAppointmentRequester: NameofAppointmentRequester,
            AppointmentSubject: AppointmentSubject,
            AppointmentMadeFromID: AppointmentMadeFrom,
            AppointmentMadeToID: AppointmentMadeTo,
            AppointmentID: AppointmentID,
            Venue: Venue,
          ),
        ));

  }

  }


