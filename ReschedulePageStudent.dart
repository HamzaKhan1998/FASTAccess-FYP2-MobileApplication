
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class ReschedulePageStudent extends StatefulWidget{
  String Teacher, Course;
  ReschedulePageStudent({
    this.Teacher,
    this.Course,
});

  @override
  ReschedulePageStudentState createState() => ReschedulePageStudentState();
}

class ReschedulePageStudentState extends State<ReschedulePageStudent> {
  int totalnoofcourses = 0, index = 0;
  String x, y;
  String p;
  //List<sItem> Item = [];

  data(String y) async
  {
    DocumentSnapshot snap = await TimetableWWWWWWWReference.doc(y).get();
    print("Doc:");
    print(snap.data()["Timing1"]);
    print(snap.data()["Timing1"].runtimeType);
    //print()
  }

  teachercourse() async {
    for(int i =0; i<widget.Course.length; i++)
      {
        if(widget.Course[i] == "(")
          {
            index = i-1;
          }
      }
    x = widget.Course.substring(0, index);
    //x = widget.Course.split("(") as String;
    print("X: $x");

    QuerySnapshot querySnapshot = await TeacherCourseInformationReference.doc(widget.Teacher).collection("Courses").get();
    DocumentSnapshot documentSnapshot;
    totalnoofcourses = querySnapshot.size;
    // print("tt: $totalnoofcourses");
    List<sItem> Item = [];
    querySnapshot.docs.forEach((element) async {
      y = element.id;
      if(y.contains(x, 0) && y!= widget.Course)
        {
           print("Element: ");
           print(element.id);
           //String k = data(y);
           TimetableWWWWWWWReference.snapshots().listen((event) {
             p = event.docs[0]["Teacher"];
           });
           //DocumentSnapshot snap = awa it TimetableWWWWWWWReference.doc(y).get();
           print("Doc:");
           print(p);
           //print(snap.data()["Timing1"]);
           Item.add(sItem.fromDocument(element.id, element.id, totalnoofcourses));
        }
    });
    return Item;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: teachercourse(),
          builder: (context, dataSnapShot){
            if(!dataSnapShot.hasData)
            {
              return circularProgress();
            }
            return ListView(children: dataSnapShot.data,);
          }
        ),
      ),
    );

  }

}
String notificationItemText;
Widget mediaPreview;

class sItem extends StatelessWidget {
  final String Class;
  final String timing;
  final int day;

  sItem({this.Class, this.timing, this.day});

  // factory sItem.fromDocument(DocumentSnapshot documentSnapshot){
  //   //print("herfff");
  //   return sItem(
  //     Class: documentSnapshot["Room1"],
  //     timing: documentSnapshot["Timing1"],
  //     day: documentSnapshot["Day1"],
  //   );
  // }
  factory sItem.fromDocument(String classs, String timingg, int teacherr){
    //print("herfff");
    return sItem(
      Class: classs,
      timing: timingg,
      day: teacherr,
    );
  }


  @override
  Widget build(BuildContext context) {

    //print("herre");

    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        color: Colors.white12,
        child: ListTile(
          title: GestureDetector(
            onTap: ()=> displayUserProfile(context, userProfileID: Class),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  style: TextStyle(fontSize: 14.0, color: Colors.blue),
                  children: [
                    TextSpan(text: timing, style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: " $notificationItemText"),
                  ]
              ),
            ),
          ),
          //subtitle: Text(tAgo.format(timestamp.toDate()), overflow: TextOverflow.ellipsis,),
          trailing: mediaPreview,
        ),
      ),
    );
  }
  displayUserProfile(BuildContext context, {String userProfileID}){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(userProfileID: userProfileID)));
  }

}

// data1()
// {
//   StreamBuilder<QuerySnapshot>(
//     stream: Firestore.instance.collection("Teacher-Course").doc(widget.Teacher).collection("Courses").snapshots(),
//     builder: (context, snapshot){
//       if(!snapshot.hasData)
//       {
//         return circularProgress();
//       }
//       else
//       {
//         //List<sItem> Item = [];
//         for(int i=0; i<snapshot.data.documents.length; i++){
//           DocumentSnapshot snap = snapshot.data.documents[i];
//           y = snap.id;
//           if(y.contains(x, 0) && y!= widget.Course)
//           {
//             print("Element: ");
//             print(snap.id);
//             snap = await TimetableWWWWWWWReference.doc(y).get();
//             print("Doc:");
//             print(snap.data()["Timing1"]);
//             Item.add(sItem.fromDocument(snap.id, snap.id, snap.id));
//           }
//         }
//
//       }
//     },
//   );
// }




