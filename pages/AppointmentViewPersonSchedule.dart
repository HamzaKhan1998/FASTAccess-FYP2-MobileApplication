

import 'package:fast_access/models/user.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppointmentPerson extends StatefulWidget{
  Userr userr;
  AppointmentPerson({
   this.userr,
});
  @override
  AppointmentPersonState createState() => AppointmentPersonState();
}

class AppointmentPersonState extends State<AppointmentPerson> {
  DateTime dateTime = DateTime.now();


  int Slot1clash = 0, Slot2clash = 0, Slot3clash = 0, Slot4clash = 0, Slot5clash = 0, Slot6clash = 0, Slot7clash = 0, ready = 0;
  String Slot1 = "09:00 - 10:00";
  String Slot2 = "10:00 - 11:00";
  String Slot3 = "11:00 - 12:00";
  String Slot4 = "12:00 - 01:00";
  String Slot5 = "01:00 - 02:00";
  String Slot6 = "02:00 - 03:00";
  String Slot7 = "03:00 - 04:00";



  calculate() async
  {
    int daycount = dateTime.weekday;
    if(widget.userr.day1 == daycount)
    {
      if(widget.userr.timing1 == Slot1)
      {
        Slot1clash = Slot1clash + 1;
      }

      else if (widget.userr.timing1 == Slot2)
      {
        Slot2clash = Slot2clash + 1;
      }

      else if (widget.userr.timing1 == Slot3)
      {
        Slot3clash = Slot3clash + 1;
      }

      else if (widget.userr.timing1 == Slot4)
      {
        Slot4clash = Slot4clash + 1;
      }

      else if (widget.userr.timing1 == Slot5)
      {
        Slot5clash = Slot5clash + 1;
      }

      else if (widget.userr.timing1 == Slot6)
      {
        Slot6clash = Slot6clash + 1;
      }
    }

    if(widget.userr.day11 == daycount)
    {
      if(widget.userr.timing11 == Slot1)
      {
        Slot1clash = Slot1clash + 1;
      }

      else if (widget.userr.timing11 == Slot2)
      {
        Slot2clash = Slot2clash + 1;
      }

      else if (widget.userr.timing11 == Slot3)
      {
        Slot3clash = Slot3clash + 1;
      }

      else if (widget.userr.timing11 == Slot4)
      {
        Slot4clash = Slot4clash + 1;
      }

      else if (widget.userr.timing11 == Slot5)
      {
        Slot5clash = Slot5clash + 1;
      }

      else if (widget.userr.timing11 == Slot6)
      {
        Slot6clash = Slot6clash + 1;
      }
    }

    ready=1;

  }

  TextSpan Heading()
  {
    return TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 17, backgroundColor: Colors.brown),
        children: [
          TextSpan(text: "Hamza",)
        ]
    );
  }

  TextSpan tryy1()
  {
    if(Slot1clash == 0)
    {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot1 (09:00 - 10:00) is free!",)
          ]
      );//("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
    }
    else
    {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot1 (09:00 - 10:00) is busy!",)
          ]
      );
      //Text("Slot1 (08:30-09:50) has $Slot1clash clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.red));
    }
  }

  TextSpan tryy2() {
    if (Slot2clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot2 (10:00 - 11:00) is free!",)
          ]
      ); //("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot2 (10:00 - 11:00) is busy!",)
          ]
      );
    }
  }

  TextSpan tryy3() {
    if (Slot3clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot3 (11:00 - 12:00) is free!",)
          ]
      ); //("Slot1 (08:30-09:50) has no clashes!", style: TextStyle(color: Colors.white, backgroundColor: Colors.green));
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot3 (11:00 - 12:00) is busy!",)
          ]
      );
    }
  }

  TextSpan tryy4()
  {
    if (Slot4clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot4 (12:00 - 01:00) is free!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot4 (12:00 - 01:00) is busy!",)
          ]
      );
    }
  }

  TextSpan tryy5()
  {
    if (Slot5clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot5 (01:00 - 02:00) is free!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot5 (01:00 - 02:00) is busy!",)
          ]
      );
    }
  }

  TextSpan tryy6()
  {
    if (Slot6clash == 0) {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot6 (02:00 - 03:00) is free!",)
          ]
      );
    }
    else {
      return TextSpan(
          style: TextStyle(color: Colors.white, fontSize: 20),
          children: [
            TextSpan(text: "Slot6 (02:00 - 03:00) is busy!",)
          ]
      );
    }
  }

  Container one () {
    if(Slot1clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy1(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy1(),
          ),
        ),
      );
    }
  }

  Container two () {
    if(Slot2clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy2(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy2(),
          ),
        ),
      );
    }
  }

  Container three () {
    if(Slot3clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy3(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy3(),
          ),
        ),
      );
    }
  }

  Container four () {
    if(Slot4clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy4(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy4(),
          ),
        ),
      );
    }
  }

  Container five () {
    if(Slot5clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy5(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy5(),
          ),
        ),
      );
    }
  }

  Container six () {
    if(Slot6clash == 0)
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.green,
        ),
        child: Center(
          child: Text.rich(
            tryy6(),
          ),
        ),
      );
    }
    else
    {
      return Container(
        width: 500,
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        child: Center(
          child: Text.rich(
            tryy6(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: calculate(),
          builder: (context, dataSnapShot)
          {
            //print("herfffppppppppppppppppppppppppppp");
            //print("noofstudents: $noofstudents, totalnoofstudents: $totalnoofstudents");
            if(ready==1)
            {
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
                      one(),
                      Divider(thickness: 1, color: Colors.grey,),
                      two(),
                      Divider(thickness: 1, color: Colors.grey,),
                      three(),
                      Divider(thickness: 1, color: Colors.grey,),
                      four(),
                      Divider(thickness: 1, color: Colors.grey,),
                      five(),
                      Divider(thickness: 1, color: Colors.grey,),
                      six(),
                      Divider(thickness: 1, color: Colors.grey,),
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
    );
  }
}