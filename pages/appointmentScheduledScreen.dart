
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/pages/PostScreenPage.dart';
import 'package:fast_access/pages/ProfilePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tAgo;
import 'package:flutter/cupertino.dart';

class appointmentScheduled extends StatefulWidget{

  appointmentScheduledState createState() => appointmentScheduledState();
}

class appointmentScheduledState extends State<appointmentScheduled> {

  retrieveAppointmentsScheduled() async {
    QuerySnapshot querySnapshot = await appointmentReference3.doc(currentUser?.id).collection("UserAppointments").get();

    // totalnoofstudents = querySnapshot.size;
     print("SIze: " + querySnapshot.size.toString());

    List<AppointmentScheduledItem> notificationsItem = [];
    querySnapshot.documents.forEach((document) {
      notificationsItem.add(AppointmentScheduledItem.fromDocument(document));
      Divider(thickness: 1, color: Colors.grey,);

      //print("herffddddddddddddddf");
    });
    //print("herffeeeeeeeeeeeeeeeeef");
    return notificationsItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, sTitle: "Appointments Scheduled"),
      body: Container(
        child: FutureBuilder(
          future: retrieveAppointmentsScheduled(),
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

}

class AppointmentScheduledItem extends StatelessWidget {
  final String Username;
  //final DateTime StartTimeofAppointment;
  final String AppointmentSubject;
  final String SenderPic;
  //final DateTime EndTimeofAppointment;
  String StartTime;
  String EndTime;
  String Venue;

  AppointmentScheduledItem({this.Username,  this.AppointmentSubject, this.SenderPic, this.StartTime, this.EndTime, this.Venue});

  factory AppointmentScheduledItem.fromDocument(DocumentSnapshot documentSnapshot){
    //print("herfff");
    return AppointmentScheduledItem(
      Username: documentSnapshot["NameofAppointmentRequester"],
      StartTime: documentSnapshot["StartTimeofAppointment"],
      EndTime: documentSnapshot["EndTimeofAppointment"],
      AppointmentSubject: documentSnapshot["AppointmentSubject"],
      SenderPic: documentSnapshot["SenderPic"],
      Venue: documentSnapshot["Venue"],
      //StartTime: documentSnapshot["SenderPic"],
      //EndTime: documentSnapshot["SenderPic"],
    );
  }


  @override
  Widget build(BuildContext context) {
    //print("ds");
    //convert();
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        color: Colors.lightBlueAccent,
        child: ListTile(
          title: GestureDetector(
            //onTap: ()=> displayUserProfile(context, userProfileID: UserID),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: Colors.indigo),
                  children: [
                    TextSpan(text: 'Appointment Made By: $Username', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: '\nSubject: $AppointmentSubject'),
                    TextSpan(text: '\nStartTime: $StartTime'),
                    TextSpan(text: '\nEndTime: $EndTime'),
                    TextSpan(text: '\nVenue: $Venue'),
                  ]
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(SenderPic),
          ),
          // leading: CircleAvatar(
          //   backgroundImage: CachedNetworkImageProvider(UserProfileIMG),
          // ),
          //subtitle: Text(tAgo.format(timestamp.toDate()), overflow: TextOverflow.ellipsis,),
          //trailing: mediaPreview,
        ),
      ),
    );
  }


}