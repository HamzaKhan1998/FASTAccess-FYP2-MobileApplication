import 'dart:async';

import 'package:fast_access/pages/CreateAccount1.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:flutter/material.dart';

class CreateAccountPage2 extends StatefulWidget {
  final String ProfileName;

  CreateAccountPage2({
    this.ProfileName
  });

  @override
  _CreateAccountPageState2 createState() => _CreateAccountPageState2();
}

class _CreateAccountPageState2 extends State<CreateAccountPage2> {
  //String username;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  //final _formKey = GlobalKey<FormState>();
  String dropdownValue;
  String Course;
  List<bool> _selections = List.generate(3, (_) => false);

  submitUsername(){
    //final form = _formKey.currentState;
    SnackBar snackBar = SnackBar(content: Text("Welcome "+ widget.ProfileName));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    Timer(Duration(seconds: 3), (){
      Navigator.pop(context, dropdownValue);
    });
  }

  changebutton2()  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage1(ProfileName: widget.ProfileName)));
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, sTitle: "Setup a Username",dbb: true),
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
                    onTap: changebutton2,
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
                    child: Container(
                      height: 100.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
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
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "3",
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
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "4",
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
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "5",
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
                    child: Container(
                      height: 60.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          "6",
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
                        "Proceed",
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
