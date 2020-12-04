
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class ReschedulePage extends StatefulWidget {
  String Course, Day;
  int DayInt;
  ReschedulePage ({
    this.Course,
    this.Day,
    this.DayInt,
  });

  @override
  ReschedulePageState createState() => ReschedulePageState();
}


class ReschedulePageState extends State<ReschedulePage> {

  int Slot1clash = 0, Slot2clash = 0, Slot3clash = 0, Slot4clash = 0, Slot5clash = 0, Slot6clash = 0, Slot7clash = 0, noofstudents = 0, totalnoofstudents = 0, daycount = 0;

    // String Slot1 = "08:30-09:50";
    // String Slot2 = "10:00-11:20";
    // String Slot3 = "11:30-12:50";
    // String Slot4 = "01:00-02:20";
    // String Slot5 = "02:30-03:50";
    // String Slot6 = "03:55-05:15";
  String Slot1 = "09:00 - 10:00";
  String Slot2 = "10:00 - 11:00";
  String Slot3 = "11:00 - 12:00";
  String Slot4 = "12:00 - 01:00";
  String Slot5 = "01:00 - 02:00";
  String Slot6 = "02:00 - 03:00";
  String Slot7 = "03:00 - 04:00";
  String Course;
  String value1;
  String Course1;
  String dropdownValue;
  String dropdownValue1;
  TextEditingController locationtextEditingController = TextEditingController();

  void initState(){
    super.initState();
    setState(() {
      daycount = widget.DayInt;
    });;
  }

  retrieveStudentsInformation() async {
    // print("w: ");
    // print(widget.Course);
    QuerySnapshot querySnapshot = await courseInformationReference.document(widget.Course).
    collection("Information").getDocuments();
    totalnoofstudents = querySnapshot.size;
    // print("tt: $totalnoofstudents");
    // print('ID of student: ');
    // print(querySnapshot.docs.first.data()['UserID']);
    //print("total : $totalnoofstudents");
    querySnapshot.documents.forEach((document) {
      noofstudents = noofstudents + 1;
      //print('NOof: $noofstudents');
      print('ID of student: ');
      print(document.data()['UserID']);
      calculate(document);
    });
  }

  calculate(DocumentSnapshot document) async
  {

    if(document.data()["Day1"] == daycount)
      {
        if(document.data()["Timing1"] == Slot1)
          {
            Slot1clash = Slot1clash + 1;
          }

        else if (document.data()["Timing1"] == Slot2)
          {
            Slot2clash = Slot2clash + 1;
          }

        else if (document.data()["Timing1"] == Slot3)
          {
            Slot3clash = Slot3clash + 1;
          }

        else if (document.data()["Timing1"] == Slot4)
          {
            Slot4clash = Slot4clash + 1;
          }

        else if (document.data()["Timing1"] == Slot5)
          {
            Slot5clash = Slot5clash + 1;
          }

        else if (document.data()["Timing1"] == Slot6)
          {
            Slot6clash = Slot6clash + 1;
          }
      }

    else if(document.data()["Day2"] == daycount)
      {
        if(document.data()["Timing2"] == Slot1)
        {
          Slot1clash = Slot1clash + 1;
        }

        else if (document.data()["Timing2"] == Slot2)
        {
          Slot2clash = Slot2clash + 1;
        }

        else if (document.data()["Timing2"] == Slot3)
        {
          Slot3clash = Slot3clash + 1;
        }

        else if (document.data()["Timing2"] == Slot4)
        {
          Slot4clash = Slot4clash + 1;
        }

        else if (document.data()["Timing2"] == Slot5)
        {
          Slot5clash = Slot5clash + 1;
        }

        else if (document.data()["Timing2"] == Slot6)
        {
          Slot6clash = Slot6clash + 1;
        }
      }

    else
      {

      }



    //forwardResults();
  }

  forwardResults() async
  {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => RescheduleResultsPage(timing1clashes: timing1clash,)));
  }

  TextSpan Heading()
  {
    return TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 17, backgroundColor: Colors.brown),
        children: [
          TextSpan(text: widget.Day,)
        ]
    );
  }

  TextSpan tryy1()
  {
    if(Slot1clash == 0)
      {
        return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
          children: [
            TextSpan(text: "Slot1 (09:00 - 10:00) has no clashes!",)
          ]
        );//("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
      }
    else
      {
        return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
            children: [
              TextSpan(text: "Slot1 (09:00 - 10:00) has $Slot1clash clashes!",)
            ]
        );
        //Text("Slot1 (08:30-09:50) has $Slot1clash clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.red));
      }
  }

  TextSpan tryy2() {
    if (Slot2clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
          children: [
            TextSpan(text: "Slot2 (10:00 - 11:00) has no clashes!",)
          ]
      ); //("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          children: [
            TextSpan(text: "Slot2 (10:00 - 11:00) has $Slot2clash clashes!",)
          ]
      );
    }
  }

  TextSpan tryy3() {
    if (Slot3clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
          children: [
            TextSpan(text: "Slot3 (11:00 - 12:00) has no clashes!",)
          ]
      ); //("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          children: [
            TextSpan(text: "Slot3 (11:00 - 12:00) has $Slot3clash clashes!",)
          ]
      );
    }
  }

  TextSpan tryy4()
  {
    if (Slot4clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
          children: [
            TextSpan(text: "Slot4 (12:00 - 01:00) has no clashes!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          children: [
            TextSpan(text: "Slot4 (12:00 - 01:00) has $Slot4clash clashes!",)
          ]
      );
    }
  }

  TextSpan tryy5()
  {
    if (Slot5clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green, fontSize: 20),
          children: [
            TextSpan(text: "Slot5 (01:00 - 02:00) has no clashes!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          children: [
            TextSpan(text: "Slot5 (01:00 - 02:00) has $Slot5clash clashes!",)
          ]
      );
    }
  }

  TextSpan tryy6()
  {
    if (Slot6clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.green),
          children: [
            TextSpan(text: "Slot6 (02:00 - 03:00) has no clashes!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, backgroundColor: Colors.red),
          children: [
            TextSpan(text: "Slot6 (02:00 - 03:00) has $Slot6clash clashes!",)
          ]
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.DayInt == 7)
      {

      }
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: retrieveStudentsInformation(),
          // ignore: missing_return
          builder: (context, dataSnapShot)
          {
            // if(!dataSnapShot.hasData)
            // {
            //   return circularProgress();
            // }
            //print("herfffppppppppppppppppppppppppppp");
            print("noofstudents: $noofstudents, totalnoofstudents: $totalnoofstudents");
            if(noofstudents == totalnoofstudents && (totalnoofstudents != 0))
              {
                daycount = daycount + 1;
                print("daycount: $daycount");
                return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Divider(),
                        Container(
                          child: Text.rich(
                            Heading(),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          width: 500,
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text.rich(
                              tryy1(),
                            ),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          child: Text.rich(
                            tryy2(),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          child: Text.rich(
                            tryy3(),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          child: Text.rich(
                            tryy4(),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          width: 500,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.green,
                          ),
                          child: Center(
                            child: Text.rich(
                              tryy5(),
                            ),
                          ),
                        ),
                        Divider(thickness: 1, color: Colors.grey,),
                        Container(
                          child: Text.rich(
                            tryy6(),
                          ),
                        ),
                      ],
                    )
                );

              }
            else
              {
                return circularProgress();
              }

            //return tryy();
          },
        ),
      ),


          // Center(
          //   child: DropdownButton<String>(
          //     value: dropdownValue,
          //     hint: new Text("Select Venue from List", style: TextStyle(color: Colors.tealAccent, fontSize: 18.0), textAlign: TextAlign.center,),
          //     icon: Icon(Icons.arrow_drop_down_outlined),
          //     iconSize: 40,
          //     elevation: 16,
          //     dropdownColor: Colors.black,
          //     style: TextStyle(color: Colors.tealAccent, fontSize: 30),
          //     underline: Container(
          //       alignment: Alignment.center,
          //       height: 2,
          //       color: Colors.limeAccent,
          //     ),
          //     onChanged: (String newValue) {
          //       setState(() {
          //         dropdownValue = newValue;
          //         Course = newValue;
          //         locationtextEditingController.text = newValue;
          //       });
          //     },
          //     items: <String>['Monday', 'Tuesday', 'Wednesday', 'C-304', 'C-305', 'C-306', 'C-307']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         value: value,
          //         child: Text(value, style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,),
          //       );
          //     }).toList(),
          //   ),
          //
          // ),

      );
  }
}

// else if(document.data()["day11"] == widget.DayInt)
//   {
//     if(document.data()["timing11"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing11"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing11"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing11"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing11"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing11"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day22"] == widget.DayInt)
//   {
//     if(document.data()["timing22"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing22"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing22"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing22"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing22"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing22"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day3"] == widget.DayInt)
//   {
//     if(document.data()["timing3"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing3"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing3"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing3"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing3"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing3"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day33"] == widget.DayInt)
//   {
//     if(document.data()["timing33"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing33"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing33"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing33"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing33"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing33"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day4"] == widget.DayInt)
//   {
//     if(document.data()["timing4"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing4"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing4"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing4"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing4"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing4"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day44"] == widget.DayInt)
//   {
//     if(document.data()["timing44"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing44"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing44"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing44"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing44"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing44"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day5"] == widget.DayInt)
//   {
//     if(document.data()["timing5"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing5"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing5"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing5"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing5"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing5"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
//   }
//
// else if(document.data()["day55"] == widget.DayInt)
//   {
//     if(document.data()["timing55"] == Slot1)
//     {
//       Slot1clash = Slot1clash + 1;
//     }
//
//     else if (document.data()["timing55"] == Slot2)
//     {
//       Slot2clash = Slot2clash + 1;
//     }
//
//     else if (document.data()["timing55"] == Slot3)
//     {
//       Slot3clash = Slot3clash + 1;
//     }
//
//     else if (document.data()["timing55"] == Slot4)
//     {
//       Slot4clash = Slot4clash + 1;
//     }
//
//     else if (document.data()["timing55"] == Slot5)
//     {
//       Slot5clash = Slot5clash + 1;
//     }
//
//     else if (document.data()["timing55"] == Slot6)
//     {
//       Slot6clash = Slot6clash + 1;
//     }
// }
