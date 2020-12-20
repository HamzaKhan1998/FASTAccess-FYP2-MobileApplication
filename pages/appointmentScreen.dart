// import 'package:buddiesgram/pages/AppointmentDetailScreen.dart';
// import 'package:buddiesgram/pages/HomePage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:buddiesgram/widgets/MiniAppointmentCard.dart';
// import 'package:buddiesgram/widgets/AppointmentCard.dart';
// import 'package:buddiesgram/widgets/SlidingCard.dart';
// import 'package:buddiesgram/Logic/AppointmentManager.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:buddiesgram/sizeConfig.dart';
// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:buddiesgram/models/user.dart';
// import 'package:buddiesgram/pages/EditCoursesPage.dart';
// import 'package:buddiesgram/pages/EditProfilePage.dart';
// import 'package:buddiesgram/pages/HomePage.dart';
// import 'package:buddiesgram/widgets/HeaderWidget.dart';
// import 'package:buddiesgram/widgets/PostTileWidget.dart';
// import 'package:buddiesgram/widgets/PostWidget.dart';
// import 'package:buddiesgram/widgets/ProgressWidget.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class AppointmentScreen extends StatefulWidget {
//   final String userProfileID;
//   AppointmentScreen({this.userProfileID});
//   @override
//   _AppointmentScreenState createState() => _AppointmentScreenState();
// }
//
// class _AppointmentScreenState extends State<AppointmentScreen> {
//
//   int tnoa;
//
//   @override
//   void initState() {
//     super.initState();
//     //initializeappointments();
//
//   }
//
//   initializeappointments() async {
//     print("hwllllllllllllllllllllll");
//     QuerySnapshot querySnapshot = await appointmentReference2.document(widget.userProfileID).
//     collection("UserAppointments").getDocuments();
//
//     tnoa = querySnapshot.documents.length;
//     print("ynoa: $tnoa");
//     //print(widget.userProfileID);
//
//     List<AppointmentItem> appointmentItem = [];
//     querySnapshot.documents.forEach((document) {
//       appointmentItem.add(AppointmentItem.fromDocument(document));
//
//     });
//
//     return appointmentItem;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: header(context, sTitle: "Appointments"),
//       body: Container(
//         child: FutureBuilder(
//           future: initializeappointments(),
//           builder: (context, dataSnapShot)
//           {
//             if(!dataSnapShot.hasData)
//             {
//               return circularProgress();
//             }
//             return ListView(children: dataSnapShot.data,);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class AppointmentItem extends StatelessWidget{
//   final String DateofAppointment;
//   final String TimeofAppointment;
//   final String AppointmentID;
//   final String AppointmentMadeTo;
//   final String AppointmentMadeFrom;
//   final String AppointmentSubject;
//   final String AppointmentDescription;
//   final String SenderPic;
//   final String NameofAppointmentRequester;
//
//   bool isFirstTime = false;
//   bool isLoading = true;
//   List<Widget> topHeader;
//   List<Widget> currentAppointment= new List<Widget>();
//   List<Widget> midHeader;
//   List<Widget> futureAppointment;
//   List<Widget> finalList;
//
//   AppointmentItem({
//     this.DateofAppointment,
//     this.TimeofAppointment,
//     this.AppointmentID,
//     this.AppointmentMadeTo,
//     this.AppointmentMadeFrom,
//     this.AppointmentSubject,
//     this.AppointmentDescription,
//     this.SenderPic,
//     this.NameofAppointmentRequester,
// });
//
//   factory AppointmentItem.fromDocument(DocumentSnapshot documentSnapshot){
//     print("in here");
//     return AppointmentItem(
//       DateofAppointment: documentSnapshot["DateofAppointment"],
//       TimeofAppointment: documentSnapshot["TimeofAppointment"],
//       AppointmentID: documentSnapshot["AppointmentID"],
//       AppointmentMadeTo: documentSnapshot["AppointmentMadeTo"],
//       AppointmentMadeFrom: documentSnapshot["AppointmentMadeFrom"],
//       AppointmentSubject: documentSnapshot["AppointmentSubject"],
//       AppointmentDescription: documentSnapshot["AppointmentDescription"],
//       SenderPic: documentSnapshot["SenderPic"],
//       NameofAppointmentRequester: documentSnapshot["NameofAppointmentRequester"],
//     );
//   }
//
//   @override
//   void initState() {
//     //super.initState();
//     topHeader = [];
//     currentAppointment = [];
//     midHeader = [];
//     futureAppointment = [];
//     finalList = [];
//
//     //AppointmentManager.generateAppointmentList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('in scafffold');
//     SizeConfig().init(context);
//     //currentAppointment..clear();
//     initiateList(context);
//     // if (isFirstTime == false) {
//     //   initiateList(context);
//     //   isFirstTime = true;
//     // }
//     return
//       // backgroundColor: Colors.grey[100],
//       // appBar: AppBar(
//       //   backgroundColor: Colors.black,//Color(0xffF3F6FF).withOpacity(0.134),
//       //   elevation: 0,
//       //   title: Text("Appointments", style: TextStyle(color: Colors.white),),
//       //   actions: <Widget>[
//       //     IconButton(
//       //       icon: Icon(
//       //         Icons.sync,
//       //         color: Colors.white,
//       //         size: SizeConfig.horizontalBloc * 8,
//       //       ),
//       //       onPressed: () async {
//       //         //setState(() {
//       //           isLoading = true;
//       //         //});
//       //
//       //         topHeader..clear();
//       //         currentAppointment..clear();
//       //         midHeader..clear();
//       //         futureAppointment.clear();
//       //         finalList..clear();
//       //         //AppointmentManager.appointmentList.clear();
//       //         //print(finalList.length);
//       //         //AppointmentManager.generateAppointmentList();
//       //         initiateList(context);
//       //
//       //         Future.delayed(Duration(milliseconds: 375), () {
//       //           isLoading = false;
//       //           //setState(() {});
//       //         });
//       //       },
//       //     )
//       //   ],
//       // ),
//        isLoading
//           ? SizedBox()
//           : Container(
//         color: Colors.black,//Color(0xffF3F6FF).withOpacity(0.134),
//         child: AnimationLimiter(
//           child: ListView.builder(
//             scrollDirection: Axis.vertical,
//             //itemCount: finalList.length,
//             itemBuilder: (BuildContext context, int index) {
//               if (isFirstTime == false) {
//                 //setState(() {});
//               }
//
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 duration: Duration(milliseconds: 375),
//                 child: SlideAnimation(
//                   verticalOffset: -20,
//                   child: FadeInAnimation(child: finalList[index]),
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//
//   }
//
//   ///I use this function to make an aggragated list this list will then be feeded into the listview"builder
//   ///IMPORTANT : Using this function i understood that gicving keys to child widget is important if you are panning on rebuilding them dynamically by adding custom parameters
//
//   Future<bool> initiateList(context) async {
//       // if (anElement.isFuture == false) {
//         SlidingCardController aController = new SlidingCardController();
//         print('adding big card');
//         currentAppointment.add(
//             Center(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: AppointmentCard(
//                 onCardTapped: () {
//                   Navigator.push(
//                       context,
//                       PageTransition(
//                           type: PageTransitionType.fade,
//                           child: AppointmentDetailScreen(
//                             DOA: DateofAppointment,
//                             TOA: TimeofAppointment,
//                             SenderPic: SenderPic,
//                             NameofAppointmentRequester: NameofAppointmentRequester,
//                             AppointmentSubject: AppointmentSubject,
//
//                           ),
//                       ),
//                   );
//                 },
//                 key: Key(Random().nextInt(4000).toString()),
//                 slidingCardController: aController,
//                 DOA: DateofAppointment,
//                 TOA: TimeofAppointment,
//                 SenderPic: SenderPic,
//                 NameofAppointmentRequester: NameofAppointmentRequester,
//                 AppointmentSubject: AppointmentSubject,
//               ),
//             )));
//      // }
//       // else {
//       //   print('adding mini card');
//       //   futureAppointment.add(Center(
//       //       child: MiniAppointmentCard(
//       //         onCardTapped: () {
//       //           Navigator.push(
//       //               context,
//       //               PageTransition(
//       //                   type: PageTransitionType.fade,
//       //                   child: AppointmentDetailScreen(
//       //                     appointmentData: anElement,
//       //                   )));
//       //         },
//       //         appointmentData: anElement,
//       //       )));
//       // }
//
//     /*midHeader.add(
//       Padding(
//         padding: const EdgeInsets.only(top: 10.0, bottom: 9, left: 20),
//         child: Container(
//           width: SizeConfig.safeBlockHorizontal * 90,
//           height: SizeConfig.verticalBloc * 3,
//           //color: Colors.pink,
//           child: Text(
//             'Next appointments',
//             style: TextStyle(
//                 fontSize: SizeConfig.horizontalBloc * 5, color: Colors.black45),
//           ),
//         ),
//       ),
//     );*/
//
//     // We create the final list that will be passed to the
//     //listView.builder
//     //finalList.addAll(topHeader);
//     //finalList.addAll(currentAppointment);
//     //finalList.addAll(midHeader);
//     //finalList.addAll(futureAppointment);
//     if (isFirstTime == false) {
//       isLoading = false;
//       //setState(() {});
//     }
//     //setState(() {});
//     return true;
//
//   }
//
// }
