import 'package:fast_access/models/user.dart';
import 'package:fast_access/pages/CalenderPage.dart';
import 'package:fast_access/pages/EditCoursesPage.dart';
import 'package:fast_access/pages/EditProfilePage.dart';
import 'package:fast_access/pages/HomePage.dart';
import 'package:fast_access/pages/NotificationsPage.dart';
import 'package:fast_access/pages/ReschedulePageBefore.dart';
import 'package:fast_access/pages/SearchPage.dart';
import 'package:fast_access/pages/appointmentScheduledScreen.dart';
import 'package:fast_access/pages/appointmentScreen1.dart';
import 'package:fast_access/widgets/HeaderWidget.dart';
import 'package:fast_access/widgets/PostTileWidget.dart';
import 'package:fast_access/widgets/PostWidget.dart';
import 'package:fast_access/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

import 'AdminAppointments.dart';
import 'AppointmentPage.dart';
import 'RescheduleStudentPageBefore.dart';



class ProfilePage extends StatefulWidget {

  final Userr gCurrentUser;
  final String userProfileID;
  final String userProfilePic;
  final String userProfileUsername;
  final String StudentLevel;
  ProfilePage({
    this.gCurrentUser,
    this.userProfileID,
    this.userProfilePic,
    this.userProfileUsername,
    this.StudentLevel,
  });


  @override
  _ProfilePageState createState() => _ProfilePageState();

}

class _ProfilePageState extends State<ProfilePage> {
  final String currentOnlineUserID = currentUser?.id;
  // final String Sendpic = currentUser?.url;
  // final String tt = currentUser?.username;
  int ctf, ctff =0;
  bool following = false;
  bool loading = false;
  int countPost = 0;
  List<Post> postsList = [];
  String postOrientation = "List";



  void initState(){
    // print("in here");
    // print(widget.userProfileID);
    // print(currentOnlineUserID);
    //  print(widget.userProfileUsername);
    //  print(widget.userProfilePic);
    getAllProfilePosts();
    getAllFollowers();
    getAllFollowing();
    checkIfAlreadyFollowing();
  }
  getAllFollowers() async {
    QuerySnapshot querySnapshot = await followersReference.document(widget.userProfileID).
    collection("UserFollowers").getDocuments();

    setState(() {
      ctf = querySnapshot.documents.length;
    });
  }

  getAllFollowing() async {
    QuerySnapshot querySnapshot = await followingReference.document(widget.userProfileID).
    collection("UserFollowing").getDocuments();


    setState(() {
      ctff = querySnapshot.documents.length;
    });
  }

  checkIfAlreadyFollowing() async {
    DocumentSnapshot documentSnapshot = await followersReference.
    document(widget.userProfileID).collection("UserFollowers").document(currentOnlineUserID).get();

    setState(() {
      following = documentSnapshot.exists;
    });
  }


  createProfileTopView() {
    return FutureBuilder(
      future: usersReference.document(widget.userProfileID).get(),
      builder: (context, dataSnapShot){
        if(!dataSnapShot.hasData)
        {
          return circularProgress();
            }


        Userr user = Userr.fromDocument(dataSnapShot.data);
        //print(dataSnapShot.data);
        DateTime date = DateTime.now();
        //print("weekday is ${date.weekday}");
        //print(date.weekday.runtimeType);

        return Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 45.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(user.url),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 5.0),

                child: Center(
                  child: Text(
                    user.profileName, style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 3.0, bottom:4),
                child: Center(
                  child: Text(
                    user.bio, style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  ),
                ),
              ),

              Row(
                children: <Widget>[


                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        /*Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            createColumns("Posts", 0),
                            createColumns("Followers", ctf),
                            createColumns("Following", ctff),
                          ],
                        ),*/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(child: createButton(),)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(child: createButton1(),)

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),


              /*Container(
                child: Text.rich(
                  buildStatus("Status", date.weekday),
                ),
              ),*/
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue),
                padding: EdgeInsets.all(15.0),
                child: Text(
                  "Schedule", style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer1(user.subject1, user.day1, user.day11, user.room1, user.room11, user.timing1, user.timing11, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer2(user.subject2, user.day2, user.day22, user.room2, user.room22, user.timing2, user.timing22, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer3(user.subject3, user.day3, user.day33, user.room3, user.room33, user.timing3, user.timing33, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer4(user.subject4, user.day4, user.day44, user.room4, user.room44, user.timing4, user.timing44, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(color: Colors.grey),
                child: Text.rich(
                  //buildContainer(user.subject1, user.timing1, user.room1),
                  buildContainer5(user.subject5, user.day5, user.day55, user.room5, user.room55, user.timing5, user.timing55, date.weekday), style: TextStyle(fontSize: 18.0, color: Colors.white70), textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
        },
    );
  }

  TextSpan buildStatus(String S, int day){

  }

  TextSpan buildContainer(String s1, String t1, String r1){
    return TextSpan(
      children: [
        TextSpan(text: s1),
        TextSpan(text: '\n$t1'),
        TextSpan(text: '\n$r1'),
      ],
    );
  }

  TextSpan buildContainer1(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
      {
        return TextSpan(
          children: [
            TextSpan(text: s1),
            TextSpan(text: '\n$t1'),
            TextSpan(text: '\n$r1'),
          ],
        );
      }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer2(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer3(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer4(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  TextSpan buildContainer5(String s1, int d1, int d11, String r1, String r11, String t1, String t11, int day){
    //print("in 1");
    if(day == d1)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
    else if(day == d11)
    {
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t11'),
          TextSpan(text: '\n$r11'),
        ],
      );
    }
    else {
      t1 = 'No Class Today!';
      r1 = 'No Class Today!';
      return TextSpan(
        children: [
          TextSpan(text: s1),
          TextSpan(text: '\n$t1'),
          TextSpan(text: '\n$r1'),
        ],
      );
    }
  }

  Column createColumns(String title, int count){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(count.toString(), style: TextStyle(fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),),
        Container(
          margin: EdgeInsets.only(top: 5.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  createButton(){
    bool ownprofile = currentOnlineUserID == widget.userProfileID;
    if(ownprofile){
      return createButtonTitleandFunction(title: "Edit Profile", performFunction: editUserProfile,);
    }
    else if(following){
      return createButtonTitleandFunction(title: "Unfollow", performFunction: controlUnfollowUser,);
    }
    else if(!following){
      return createButtonTitleandFunction(title: "Follow", performFunction: controlFollowUser,);
    }
  }

  createButton1(){
    bool ownprofile = currentOnlineUserID == widget.userProfileID;
    if(ownprofile){
      return createButtonTitleandFunction1(title: "Edit Courses", performFunction: editCourses,);
    }
    else {
      return createButtonTitleandFunction1(title: "Book Appointment", performFunction: bookAppointment,);
    }
  }

  controlUnfollowUser(){
    setState(() {
      following = false;
    });
    followersReference.document(widget.userProfileID).collection("UserFollowers").
    document(currentOnlineUserID).get().then((document) {
      if(document.exists)
        {
          document.reference.delete();
        }
    });

    followingReference.document(currentOnlineUserID).collection("UserFollowing").
    document(widget.userProfileID).get().then((document) {
      if(document.exists)
      {
        document.reference.delete();
      }
    });

    activityFeedReference.document(widget.userProfileID).collection("FeedItems").
    document(currentOnlineUserID).get().then((document) {
      if(document.exists)
        {
          document.reference.delete();
        }
    });
  }

  controlFollowUser(){
    setState(() {
      following = true;
    });

    followersReference.document(widget.userProfileID)
    .collection("UserFollowers").document(currentOnlineUserID).setData({});

    followingReference.document(currentOnlineUserID)
        .collection("UserFollowing").document(widget.userProfileID).setData({});

    activityFeedReference.document(widget.userProfileID)
    .collection("FeedItems").document(currentOnlineUserID).setData({
      "Type": "Follow",
      "OwnerID": widget.userProfileID,
      "Username": currentUser.profileName,
      "Timestamp": DateTime.now(),
      "UserProfileIMG": currentUser.url,
      "UserID": currentOnlineUserID,
      "CommentData": "",
      "URL": "",
      "PostID": "",
    });

  }





  Container createButtonTitleandFunction({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 225.0,
          height: 26.0,
          child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }

  Container createButtonTitleandFunction1({String title, Function performFunction}){
    return Container(
      padding: EdgeInsets.only(top: 3.0),
      child: FlatButton(
        onPressed: performFunction,
        child: Container(
          width: 225.0,
          height: 26.0,
          child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6.0),
          ),
        ),
      ),
    );
  }
  
  editUserProfile(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(currentOnlineUserID: currentOnlineUserID)));
  }

  editCourses(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditCoursesPage(currentOnlineUserID: currentOnlineUserID, StudentLevel: widget.StudentLevel,)));
  }

  bookAppointment(){
    // print("heloooooooooo");
     print(widget.userProfileUsername);
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentPage(gCurrentUser: widget.gCurrentUser, currentOnlineUserID: currentOnlineUserID, SenderPic: widget.userProfilePic, Username: widget.userProfileUsername,)));
  }

  reschedule()
  {
    if(currentUser.accounttype == 'Teacher')
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReschedulePageBefore()));
      }
    else
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => RescheduleStudentPageBefore()));
      }
  }

  gotoadmin()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
  }

  gotoAppointmentsRequests()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentScreen2()));
  }

  gotoAppointmentsScheduled()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => appointmentScheduled()));
  }

  gotoAppointmentsNew()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentPage(gCurrentUser: widget.gCurrentUser, currentOnlineUserID: currentOnlineUserID,
    Username: widget.userProfileUsername, SenderPic: widget.userProfilePic,)
    ));
  }


  gotoCalender()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderPage(gCurrentUser: widget.gCurrentUser,)));
  }

  Drawer getDrawer(context) {
    print("in here");
    if(currentUser?.accounttype == "Teacher")
      {print("Teacher");
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  widget.userProfileUsername,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              ExpansionTile(
                leading: Icon(Icons.group_add),
                title: Text('Appointments', style: TextStyle(color: Colors.blue),),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('New', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsNew,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Requests', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsRequests,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Scheduled', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsScheduled,
                  ),

                ],
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Calender', style: TextStyle(color: Colors.blue),),
              ),
              // ListTile(
              //   leading: Icon(Icons.calendar_today),
              //   title: Text('Courses', style: TextStyle(color: Colors.blue),),
              // ),
              ExpansionTile(
                leading: Icon(Icons.post_add),
                title: Text('Posts', style: TextStyle(color: Colors.blue),),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('New', style: TextStyle(color: Colors.blue),),

                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Created', style: TextStyle(color: Colors.blue),),
                    //onTap: ,
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.loop_rounded),
                title: Text('Reschedule Class', style: TextStyle(color: Colors.blue),),
                onTap: reschedule,
              ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings', style: TextStyle(color: Colors.blue),),
              //   onTap: reschedule,
              // ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout', style: TextStyle(color: Colors.blue),),
                //onTap: resourcerequests,
              ),
            ],
          ),
        );
      }
    else if (currentUser?.accounttype == "Admin")
      {print("admin");
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  widget.userProfileUsername,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),

              ExpansionTile(
                leading: Icon(Icons.group_add),
                title: Text('Appointments', style: TextStyle(color: Colors.blue),),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('New', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsNew,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Requests', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsRequests,
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Scheduled', style: TextStyle(color: Colors.blue),),
                    onTap: gotoAppointmentsScheduled,
                  ),

                ],
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Calender', style: TextStyle(color: Colors.blue),),
              ),
              // ListTile(
              //   leading: Icon(Icons.calendar_today),
              //   title: Text('Courses', style: TextStyle(color: Colors.blue),),
              // ),
              ExpansionTile(
                leading: Icon(Icons.post_add),
                title: Text('Posts', style: TextStyle(color: Colors.blue),),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('New', style: TextStyle(color: Colors.blue),),

                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_right_outlined),
                    title: Text('Created', style: TextStyle(color: Colors.blue),),
                    //onTap: ,
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.fact_check_sharp),
                title: Text('Resource Requests', style: TextStyle(color: Colors.blue),),
                onTap: resourcerequests,
              ),
              // ListTile(
              //   leading: Icon(Icons.settings),
              //   title: Text('Settings', style: TextStyle(color: Colors.blue),),
              //   onTap: reschedule,
              // ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Logout', style: TextStyle(color: Colors.blue),),
                //onTap: resourcerequests,
              ),
            ],
          ),
        );
      }

    else {
      print("heloo");
      print(currentUser?.accounttype);
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                widget.userProfileUsername,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            ExpansionTile(
              leading: Icon(Icons.group_add),
              title: Text('Appointments', style: TextStyle(color: Colors.blue),),
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.arrow_right_outlined),
                  title: Text('New', style: TextStyle(color: Colors.blue),),
                  onTap: gotoAppointmentsNew,
                ),
                ListTile(
                  leading: Icon(Icons.arrow_right_outlined),
                  title: Text('Requests', style: TextStyle(color: Colors.blue),),
                  onTap: gotoAppointmentsRequests,
                ),
                ListTile(
                  leading: Icon(Icons.arrow_right_outlined),
                  title: Text('Scheduled', style: TextStyle(color: Colors.blue),),
                  onTap: gotoAppointmentsScheduled,
                ),

              ],
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Calender', style: TextStyle(color: Colors.blue),),
            ),
            // ListTile(
            //   leading: Icon(Icons.calendar_today),
            //   title: Text('Courses', style: TextStyle(color: Colors.blue),),
            // ),
            ListTile(
              leading: Icon(Icons.loop_rounded),
              title: Text('Reschedule Class', style: TextStyle(color: Colors.blue),),
              onTap: reschedule,
            ),
            // ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('Settings', style: TextStyle(color: Colors.blue),),
            //   onTap: reschedule,
            // ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout', style: TextStyle(color: Colors.blue),),
              //onTap: resourcerequests,
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: getDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          height: 40,
          child: TextFormField(
            style: TextStyle(fontSize: 17.0, color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search Here...",
              hintStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              filled: true,
              prefixIcon: Icon(Icons.search, color: Colors.blue, size: 25.0,),
            ),
            onTap: goto,
          ),
        ),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.blue,),
              onPressed: gotoNotifications,
            )
          ],
      ),
      body: ListView(
        children: <Widget>[
          createProfileTopView(),
          Divider(),
          createListAndGrid(),
          Divider(height: 0.0,),
          displayProfilePost(),
        ],
      ),
    );
  }

  resourcerequests()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Admin()));
  }
  goto()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  gotoNotifications()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsPage()));
  }

  displayProfilePost(){
    if(loading)
      {
        return circularProgress();
      }
    else if(postsList.isEmpty)
      {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Icon(Icons.photo_library, color: Colors.grey, size: 200.0,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Text("No Posts", style: TextStyle(color: Colors.redAccent, fontSize: 40.0, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        );
      }

    /*else if(postOrientation == "Grid")
      {
        List<GridTile> gridTilesList = [];
        postsList.forEach((eachPost) {
          gridTilesList.add(GridTile(child: PostTile(eachPost)));
        });
        return GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          mainAxisSpacing: 1.5,
          crossAxisSpacing: 1.5,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: gridTilesList,
        );
      }*/

    else if(postOrientation == "List")
      {
        return Column(
          children: postsList,
        );
      }


  }

  getAllProfilePosts() async {
    setState(() {
      loading = true;
    });

    QuerySnapshot querySnapshot = await postsReference.document(widget.userProfileID).collection("UsersPosts").orderBy("Timestamp", descending: true).getDocuments();

    setState(() {
      loading = false;
      countPost = querySnapshot.documents.length;
      postsList = querySnapshot.documents.map((documentSnapshot) => Post.fromDocument(documentSnapshot)).toList();
    });
  }

  createListAndGrid(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      /*children: <Widget>[
        IconButton(
          icon: Icon(Icons.grid_on),
          onPressed: ()=> setOrientation("Grid"),
          color: postOrientation == "Grid" ? Theme.of(context).primaryColor: Colors.grey,
        ),
        IconButton(
          icon: Icon(Icons.list),
          onPressed: ()=> setOrientation("List"),
          color: postOrientation == "List" ? Theme.of(context).primaryColor: Colors.grey,
        ),
      ],*/
    );
  }

  setOrientation(String orientation){
    setState(() {
      this.postOrientation = orientation;
    });
  }
}
