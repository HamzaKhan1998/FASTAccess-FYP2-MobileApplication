import 'dart:async';

import 'package:fast_access/pages/CreateAccount2.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';

class CreateAccountPage1 extends StatefulWidget {
  final String ProfileName;

  CreateAccountPage1({
    this.ProfileName
  });

  @override
  _CreateAccountPageState1 createState() => _CreateAccountPageState1();
}

class _CreateAccountPageState1 extends State<CreateAccountPage1> {
  //String username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //final _formKey = GlobalKey<FormState>();
  String dropdownValue;
  String Course;

  submitUsername(){
    //final form = _formKey.currentState;
    SnackBar snackBar = SnackBar(content: Text("Welcome "+ widget.ProfileName));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    Timer(Duration(seconds: 3), (){
      Navigator.pop(context, dropdownValue);
    });
  }

  changebutton1() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage2(ProfileName: widget.ProfileName)));
  }


  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, sTitle: "Setup a Username",dbb: true),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/a.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView(
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
                      child: Container(
                        height: 100.0,
                        width: 150.0,
                        decoration: BoxDecoration(
                          color: Colors.red,
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
                      onTap: changebutton1,
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
      ),
    );
  }
}
