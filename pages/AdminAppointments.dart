
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

class Admin extends StatefulWidget{

  AdminState createState() => AdminState();
}

class AdminState extends State<Admin> {

  retrieveAdminNotifications() async {
    QuerySnapshot querySnapshot = await AdminReference.getDocuments();

    // totalnoofstudents = querySnapshot.size;
    // print("tt: $totalnoofstudents");

    List<AdminNotificationsItem> notificationsItem = [];
    querySnapshot.documents.forEach((document) {
      notificationsItem.add(AdminNotificationsItem.fromDocument(document));
      Divider(thickness: 1, color: Colors.grey,);

      //print("herffddddddddddddddf");
    });
    //print("herffeeeeeeeeeeeeeeeeef");
    return notificationsItem;
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: header(context, sTitle: "Resource Requests "),
        body: Container(
          child: FutureBuilder(
            future: retrieveAdminNotifications(),
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

class AdminNotificationsItem extends StatelessWidget {
  final String Username;
  final DateTime StartTimeofAppointment;
  final String Resources;
  final String SenderPic;
  final DateTime EndTimeofAppointment;
  String StartTime;
  String EndTime, Venue;

  AdminNotificationsItem({this.Username,  this.Resources, this.SenderPic, this.EndTimeofAppointment, this.StartTimeofAppointment, this.StartTime, this.EndTime, this.Venue});

  factory AdminNotificationsItem.fromDocument(DocumentSnapshot documentSnapshot){
    //print("herfff");
    return AdminNotificationsItem(
      Username: documentSnapshot["AppointmentMadeFrom"],
      StartTimeofAppointment: documentSnapshot["StartTimeofAppointment"].toDate(),
      EndTimeofAppointment: documentSnapshot["EndTimeofAppointment"].toDate(),
      Resources: documentSnapshot["Resources"],
      SenderPic: documentSnapshot["SenderPic"],
      StartTime: documentSnapshot["SenderPic"],
      EndTime: documentSnapshot["SenderPic"],
      Venue: documentSnapshot["Venue"],
    );
  }

  convert()
  {
    //print("here");
    StartTime = "${StartTimeofAppointment.year.toString()}-${StartTimeofAppointment.month.toString().padLeft(2,'0')}-${StartTimeofAppointment.day.toString().padLeft(2,'0')} ${StartTimeofAppointment.hour.toString()}:${StartTimeofAppointment.minute.toString()}";
    EndTime = "${EndTimeofAppointment.year.toString()}-${EndTimeofAppointment.month.toString().padLeft(2,'0')}-${EndTimeofAppointment.day.toString().padLeft(2,'0')} ${EndTimeofAppointment.hour.toString()}:${EndTimeofAppointment.minute.toString()}";
    //print("here1");
  }


  @override
  Widget build(BuildContext context) {
    //print("ds");
    convert();
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
                    TextSpan(text: '\nResources: $Resources'),
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