import 'dart:async';

import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';

import 'package:fast_access/pages/CreateAccount1.dart';
import 'package:fast_access/pages/CreateAccount2.dart';


class CreateAccountPage extends StatefulWidget {
  final String ProfileName;

  CreateAccountPage({
    this.ProfileName
});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  //String username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //final _formKey = GlobalKey<FormState>();
  String Degreetitle;
  String Course;
  List<bool> _selections;
  List<bool> isSelected;

  submitUsername(){
    //final form = _formKey.currentState;
    SnackBar snackBar = SnackBar(content: Text("Welcome "+ widget.ProfileName));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    Timer(Duration(seconds: 3), (){
      Navigator.pop(context, Degreetitle);
    });
  }

  @override
  void initState()
  {

    super.initState();
    isSelected = [true, false, false];
    _selections = [
      true,
      false,
      false,
      false,
      false,
    ];
  }


  changebutton()  {

    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage1(ProfileName: widget.ProfileName)));
  }

  changebutton4()  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage2(ProfileName: widget.ProfileName)));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, sTitle: "Select Degree Program",dbb: true),
      body: ListView(
        children: <Widget>[
          Center(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: changebutton,
                    child: Container(
                      height: 100.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "BS",
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

                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: changebutton4,
                    child: Container(
                      height: 100.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "MS",
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
          ),

          Divider(),
          Divider(),

          ToggleButtons(
            children: <Widget>[
              Icon(Icons.ac_unit),
              Icon(Icons.call),
              Icon(Icons.cake),
            ],
            onPressed: (int index) {
              setState(() {
                for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                  if (buttonIndex == index) {
                    isSelected[buttonIndex] = true;
                  } else {
                    isSelected[buttonIndex] = false;
                  }
                }
              });
            },
            isSelected: isSelected,
          ),



          Divider(), //----------------------------------------------------------------------------


          Center(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: submitUsername,
                  child: Container(
                    height: 45.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
