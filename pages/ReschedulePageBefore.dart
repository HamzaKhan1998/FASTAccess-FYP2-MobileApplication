
import 'package:fast_access/pages/ReschedulePage.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReschedulePageBefore extends StatefulWidget{

  @override
  ReschedulePageBeforeState createState() => ReschedulePageBeforeState();

}

class ReschedulePageBeforeState extends State<ReschedulePageBefore> {
  String CoursedropdownValue, DaydropdownValue;
  int DaydropdownValueInt;
  toReschedulePage()
  {

    if(DaydropdownValue == "Monday")
      {
        DaydropdownValueInt = 1;
      }
    else if(DaydropdownValue == "Tuesday")
      {
        DaydropdownValueInt = 2;
      }
    else if(DaydropdownValue == "Wednesday")
    {
      DaydropdownValueInt = 3;
    }
    else if(DaydropdownValue == "Thursday")
    {
      DaydropdownValueInt = 4;
    }
    else if(DaydropdownValue == "Friday")
    {
      DaydropdownValueInt = 5;
    }
    else if(DaydropdownValue == "Saturday")
    {
      DaydropdownValueInt = 6;
    }
    else
    {
      DaydropdownValueInt = 7;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => ReschedulePage(Course: CoursedropdownValue, Day: DaydropdownValue, DayInt: DaydropdownValueInt,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context, sTitle: "Reschedule Class"),
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

          Center(
            child: DropdownButton<String>(
              value: DaydropdownValue,
              hint: new Text("Select Day from List", style: TextStyle(color: Colors.tealAccent, fontSize: 18.0), textAlign: TextAlign.center,),
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
                  DaydropdownValue = newValue;
                });
              },
              items: <String>['All Days', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']
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

          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                ),
              ),

              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: toReschedulePage,
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
          )

        ],
      ),
    );

  }
}