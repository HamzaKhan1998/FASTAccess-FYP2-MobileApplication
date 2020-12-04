
import 'dart:io';

import 'package:fast_access/models/user.dart';
import 'package:fast_access/pages/CalenderPage.dart';
import 'package:fast_access/pages/CreateAccountPage.dart';
import 'package:fast_access/pages/ReschedulePage.dart';
import 'package:fast_access/pages/ReschedulePageBefore.dart';
import 'package:fast_access/pages/Timeline2.dart';
import 'package:fast_access/pages/appointmentScreen.dart';
import 'package:fast_access/pages/appointmentScreen1.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_access/pages/NotificationsPage.dart';
import 'package:fast_access/pages/ProfilePage.dart';
import 'package:fast_access/pages/SearchPage.dart';
import 'package:fast_access/pages/TimeLinePage.dart';
import 'package:fast_access/pages/UploadPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'RescheduleStudentPageBefore.dart';



final GoogleSignIn gSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("Users");
final DateTime timestamp = DateTime.now();
Userr currentUser;
final postsReference = Firestore.instance.collection("Posts");
final StorageReference storageReference = FirebaseStorage.instance.ref().child("Posts Pictures");
final followersReference = Firestore.instance.collection("Followers");
final followingReference = Firestore.instance.collection("Following");
final activityFeedReference = Firestore.instance.collection("Feed");
final appointmentReference1 = Firestore.instance.collection("AppointmentsMadeFrom");
final appointmentReference2 = Firestore.instance.collection("AppointmentsMadeTo");
final timelineReference = Firestore.instance.collection("Timeline");
final commentsReference = Firestore.instance.collection("Comments");
final courseInformationReference = Firestore.instance.collection("CourseInfo");
final TeacherCourseInformationReference = Firestore.instance.collection("Teacher-Course");
final TimetableWWWWWWWReference = Firestore.instance.collection("TimetableWWWWWWW");
final RoomReference = Firestore.instance.collection("Rooms");
final AdminReference = Firestore.instance.collection("AdminNotifications");


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool loading = true;
  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex = 0;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String accounttype = "General User";

  void initState(){
    super.initState();

    pageController = PageController();

    gSignIn.onCurrentUserChanged.listen((gSignInAccount){
      controlSignIn(gSignInAccount);
    }, onError: (gError){
      //print("Error Message: "+ gError);
      loading = false;
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount){
      controlSignIn(gSignInAccount);
    }).catchError((gError){
      //print("Error Message: "+ gError);
      loading = false;
    });

  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if(signInAccount!= null)
    {
      //checkUserType(context);
      await saveInfo();
      setState(() {
        isSignedIn = true;
        loading = false;
      });

      configureRealTime();
    }

    else
    {
      setState(() {
        isSignedIn = false;
      });
    }

  }

  configureRealTime(){
    final GoogleSignInAccount googleSignInAccount = gSignIn.currentUser;
    if(Platform.isIOS)
      {
        getIOSPermissions();
      }
    _firebaseMessaging.getToken().then((token) {
      usersReference.document(googleSignInAccount.id).updateData({"androidNotificationToken": token});
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> msg) async {
        final String recipentID = msg["data"]["recipent"];
        final String body = msg["notfication"]["body"];

        if(recipentID == googleSignInAccount.id)
          {
            SnackBar snackBar = SnackBar(
              backgroundColor: Colors.grey,
              content: Text(body, style: TextStyle(color: Colors.black), overflow: TextOverflow.ellipsis,),
            );
            _scaffoldKey.currentState.showSnackBar(snackBar);
          }
      },
    );
  }

  getIOSPermissions(){
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(alert: true, badge: true, sound: true));
    _firebaseMessaging.onIosSettingsRegistered.listen((settings) {
      print("Settings Registered: $settings");
    });
  }

  checkUserType(BuildContext context) {
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    return showDialog(
        context: context,
        // ignore: missing_return
        builder: (context){
            if(gCurrentUser.email.endsWith("@nu.edu.pk"))
              {
                if(gCurrentUser.email.startsWith("i",0))
                {
                  if(gCurrentUser.email.length == 17)
                    {
                      accounttype = 'Student';
                      // AlertDialog(
                      //   title: Text("Successfully logged in as Student", style: TextStyle(color: Colors.white),),
                      //   content: Text("Welcome", style: TextStyle(color: Colors.white),),
                      //   backgroundColor: Colors.black,
                      // );
                      return AlertDialog(
                        title: Text("Welcome", style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                        backgroundColor: Colors.black,
                        actions: <Widget>[
                          MaterialButton(
                            child: Text("Proceed"),
                            onPressed: ()
                              {
                                Navigator.pop(context);
                              },

                          ),
                        ],
                      );

                    }
                  else
                    {
                      // AlertDialog(
                      //   title: Text("Length of "),
                      // );
                    }
                }
                else
                  {
                    if(gCurrentUser.email.contains(".", 0))
                      {
                        accounttype = 'Teacher';
                        return AlertDialog(
                          title: Text("Successfully logged in as Teacher", style: TextStyle(color: Colors.white),),
                          content: Text("Welcome", style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.black,
                          actions: <Widget>[
                            MaterialButton(
                              child: Text("Proceed"),
                              onPressed: ()
                              {
                                Navigator.pop(context);
                              },

                            ),
                          ],
                        );
                      }
                  }
              }
            else
              {
                return AlertDialog(
                  title: Text("Not an NU Mail, app not accessible!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  backgroundColor: Colors.black,
                  actions: <Widget>[
                    MaterialButton(
                      child: Text("Exit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      onPressed: ()
                      {
                        logoutUser();
                        Navigator.pop(context);
                      },

                    ),
                  ],
                );
              }

          }
  );
  }

  saveInfo() async{
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    if(!documentSnapshot.exists){
      final StudentLevel = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage(ProfileName: gCurrentUser.displayName)));

      usersReference.document(gCurrentUser.id).setData({
      "id": gCurrentUser.id,
      "profileName": gCurrentUser.displayName,
      //"username": username,
        "StudentLevel": StudentLevel,
      "url": gCurrentUser.photoUrl,
      "email": gCurrentUser.email,
      "bio": "(Any message for the viewer)",
      "timestamp": timestamp,
        "accounttype":  accounttype,
        "subject1" : "Empty",
        "subject2" : "Empty",
        "subject3" : "Empty",
        "subject4" : "Empty",
        "subject5" : "Empty",
        "timing1" : "Empty",
        "room1" : "Empty",
        "timing2" : "Empty",
        "room2" : "Empty",
        "timing3" : "Empty",
        "room3" : "Empty",
        "timing4" : "Empty",
        "room4" : "Empty",
        "timing5" : "Empty",
        "room5" : "Empty",
        "timing11" : "Empty",
        "room11" : "Empty",
        "timing22" : "Empty",
        "room22" : "Empty",
        "timing33" : "Empty",
        "room33" : "Empty",
        "timing44" : "Empty",
        "room44" : "Empty",
        "timing55" : "Empty",
        "room55" : "Empty",
        "day1": 0,
        "day2": 0,
        "day3": 0,
        "day4": 0,
        "day5": 0,
        "day11": 0,
        "day22": 0,
        "day33": 0,
        "day44": 0,
        "day55": 0,
      });

      await followersReference.document(gCurrentUser.id).collection("UserFollowers").document(gCurrentUser.id).setData({});

      documentSnapshot = await usersReference.document(gCurrentUser.id).get();
    }
    
    currentUser = Userr.fromDocument(documentSnapshot);
  }

  void dispose(){
    pageController.dispose();
    super.dispose();

  }

  loginUser(){
    gSignIn.signIn();
  }

  logoutUser(){
    gSignIn.signOut();
  }

  whenPageChanges(int pageIndex){
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  onTapChangePage(int pageIndex){
    pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 400), curve: Curves.bounceInOut);
  }

  Scaffold buildHomeScreen(){
    // print("Over here");
    // print(currentUser.url);
    // print(currentUser.username);
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          Timeline2(gCurrentUser: currentUser, userProfileID: currentUser.id, userProfilePic: currentUser.url, userProfileUsername: currentUser.profileName, StudentLevel: currentUser.StudentLevel,),
           SearchPage(),
           UploadPage(gCurrentUser: currentUser,),
          AppointmentScreen2(userProfileID: currentUser.id,),
          NotificationsPage(),
          ProfilePage(gCurrentUser: currentUser, userProfileID: currentUser.id, userProfilePic: currentUser.url, userProfileUsername: currentUser.profileName, StudentLevel: currentUser.StudentLevel,),
          //logoutUser(),
            RescheduleStudentPageBefore(),
          //CalenderPage(gCurrentUser: currentUser,),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
        backgroundColor: Theme.of(context).accentColor,
        activeColor: Colors.blue,
        inactiveColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.announcement)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.post_add)),
          BottomNavigationBarItem(icon: Icon(Icons.group_add)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today)),
        ],
      ),

    );
  }

  /*Widget buildHomeScreen() {
    return RaisedButton.icon(onPressed: logoutUser, icon: Icon(Icons.close), label: Text("Sign Out"));
  }*/



  Scaffold buildSignInScreen(){
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/q.jpeg")
          ),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          )
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "FASTAccess",
              style: TextStyle(fontSize: 60.0, color: Colors.blueAccent, fontFamily: "Metallord"),
            ),
            GestureDetector(
              onTap: loginUser,
              child: loading ? circularProgress() : Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image:  DecorationImage(
                    image:  AssetImage("assets/images/o.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    if(isSignedIn)
      {
        return buildHomeScreen();
      }
    else
      {
        return buildSignInScreen();
      }
    //return buildHomeScreen();
  }
}

