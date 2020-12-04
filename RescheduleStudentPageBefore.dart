import 'package:fast_access/pages/ReschedulePageStudent.dart';
import 'package:fast_access/pages/ReschedulePageStudent1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class RescheduleStudentPageBefore extends StatefulWidget {

  @override
  RescheduleStudentPageBeforeState createState() => RescheduleStudentPageBeforeState();
}

class RescheduleStudentPageBeforeState extends State<RescheduleStudentPageBefore> {
  String CoursedropdownValue, DaydropdownValue;
  int DaydropdownValueInt;
  int totalnoofcourses = 0, index = 0, loop = 0;
  String x, y;
  String subject1, subject2, timing1, timing2;

  toReschedulePageStudent() async {
    DocumentSnapshot documentSnapshot  = await TimetableWWWWWWWReference.doc(CoursedropdownValue).get();
    String teacher = documentSnapshot.get("Teacher");
    print("Teacher: $teacher");
    for(int i =0; i<CoursedropdownValue.length; i++)
    {
      if(CoursedropdownValue[i] == "(")
      {
        index = i-1;
      }
    }
    x = CoursedropdownValue.substring(0, index);
    //x = widget.Course.split("(") as String;
    print("X: $x");

    QuerySnapshot querySnapshot = await TeacherCourseInformationReference.doc(teacher).collection("Courses").get();

    totalnoofcourses = querySnapshot.size;
    // print("tt: $totalnoofcourses");
    List<sItem> Item = [];
    querySnapshot.docs.forEach((element) async {
      y = element.id;
      if(y.contains(x, 0) && y!= CoursedropdownValue)
      {
        print("Element: ");
        print(element.id);
        //String k = data(y);
        DocumentSnapshot snap = await TimetableWWWWWWWReference.doc(y).get();
        print("Doc:");
        print(snap.data()["Timing1"]);
        if(loop == 0)
          {
            subject1 = element.id;
            timing1 = snap.data()["Timing1"];
          }
        else
          {
            subject2 = element.id;
            timing2 = snap.data()["Timing1"];
          }

        //Item.add(sItem.fromDocument(snap));
      }
    });
    //return Item;
    Navigator.push(context, MaterialPageRoute(builder: (context) => Student(Course1: subject1, Course1timing: timing1,)));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[

          Center(
            child: DropdownButton<String>(
              value: CoursedropdownValue,
              hint: new Text("Select Course from List", style: TextStyle(color: Colors.tealAccent, fontSize: 18.0), textAlign: TextAlign.center,),
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
                  CoursedropdownValue = newValue;
                });
              },
              items: <String>['Parallel Processing', 'Advanced Sw Arch. (SE)', 'ALGO (2-C) ']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
                );
              }).toList(),
            ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                ),
              ),

              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: toReschedulePageStudent,
                  child: Container(
                    height: 50.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "Reschedule Class",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: SizedBox(
                ),
              ),
            ],
          ),

        ],
      ),
    );

  }
}