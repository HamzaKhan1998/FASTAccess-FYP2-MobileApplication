import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/CreateAccountPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:buddiesgram/pages/NotificationsPage.dart';
import 'package:buddiesgram/pages/ProfilePage.dart';
import 'package:buddiesgram/pages/SearchPage.dart';
import 'package:buddiesgram/pages/TimeLinePage.dart';
import 'package:buddiesgram/pages/UploadPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


final GoogleSignIn gSignIn = GoogleSignIn();
final usersReference = Firestore.instance.collection("Users");
final DateTime timestamp = DateTime.now();
User currentUser;
final postsReference = Firestore.instance.collection("Posts");
final StorageReference storageReference = FirebaseStorage.instance.ref().child("Posts Pictures");

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isSignedIn = false;
  PageController pageController;
  int getPageIndex = 0;

  void initState(){
    super.initState();

    pageController = PageController();

    gSignIn.onCurrentUserChanged.listen((gSignInAccount){
      controlSignIn(gSignInAccount);
    }, onError: (gError){
      print("Error Message: "+ gError);
    });

    gSignIn.signInSilently(suppressErrors: false).then((gSignInAccount){
      controlSignIn(gSignInAccount);
    }).catchError((gError){
      print("Error Message: "+ gError);
    });

  }

  controlSignIn(GoogleSignInAccount signInAccount) async {
    if(signInAccount!= null)
    {
      await saveInfo();
      setState(() {
        isSignedIn = true;
      });
    }

    else
    {
      setState(() {
        isSignedIn = false;
      });
    }

  }

  saveInfo() async{
    final GoogleSignInAccount gCurrentUser = gSignIn.currentUser;
    DocumentSnapshot documentSnapshot = await usersReference.document(gCurrentUser.id).get();

    if(!documentSnapshot.exists){
      final username = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage()));

      usersReference.document(gCurrentUser.id).setData({
      "id": gCurrentUser.id,
      "profileName": gCurrentUser.displayName,
      "username": username,
      "url": gCurrentUser.photoUrl,
      "email": gCurrentUser.email,
      "bio": "",
      "timestamp": timestamp,
      });
      documentSnapshot = await usersReference.document(gCurrentUser.id).get();
    }
    
    currentUser = User.fromDocument(documentSnapshot);
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
    return Scaffold(
      body: PageView(
        children: <Widget>[
          TimeLinePage(),
          SearchPage(),
          UploadPage(gCurrentUser: currentUser,),
          NotificationsPage(),
          ProfilePage(userProfileID: currentUser.id,),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        onTap: onTapChangePage,
        backgroundColor: Theme.of(context).accentColor,
        activeColor: Colors.white,
        inactiveColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.announcement)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.post_add)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
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
              style: TextStyle(fontSize: 70.0, color: Colors.white, fontFamily: "Metallord"),
            ),
            GestureDetector(
              onTap: loginUser,
              child: Container(
                width: 270.0,
                height: 65.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/google_signin_button.png"),
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
  }
}

