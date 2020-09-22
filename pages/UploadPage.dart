import 'dart:io';
import 'package:buddiesgram/pages/DB.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;
import 'package:sqflite/sqflite.dart';
import 'package:buddiesgram/models/user.dart';
import 'package:buddiesgram/pages/HomePage.dart';
import 'package:buddiesgram/widgets/ProgressWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as IMD;
import 'dart:async';



class UploadPage extends StatefulWidget {
  final User gCurrentUser;

  UploadPage({this.gCurrentUser});
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> with AutomaticKeepAliveClientMixin<UploadPage> {
  File file;
  bool up = false;
  bool picavailable = false;
  String postID = Uuid().v4();
  TextEditingController descriptiontextEditingController = TextEditingController();
  TextEditingController locationtextEditingController = TextEditingController();
  List<DropdownMenuItem<String>> list;

  captureImageWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 680,
      maxWidth: 970,
    );

    setState(() {
      this.file = imageFile;
    });
  }

  pickImageFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
    );

    setState(() {
      this.file = imageFile;
    });
  }

  venue1(){
    Navigator.pop(context);
    String v = "C-301";
    locationtextEditingController.text = v;
  }

  venue2(){
    Navigator.pop(context);
    String v = "C-302";
    locationtextEditingController.text = v;
  }

  venue3(){
    Navigator.pop(context);
    String v = "C-303";
    locationtextEditingController.text = v;
  }

  venues(){
    return showDialog(
      context: context,
      builder: (context){
        return SimpleDialog(
          title: Text("Venues", style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("C-301", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: venue1,
            ),
            SimpleDialogOption(
              child: Text("C-302", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: venue2,
            ),
            SimpleDialogOption(
              child: Text("C-303", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: venue3,
            ),
          ],
        );
      }
    );
  }

  takeImage(mContext){
    return showDialog(
      context: mContext,
      builder: (context){
        return SimpleDialog(
          title: Text("Upload Image", style: TextStyle(color: Colors.tealAccent, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          children: <Widget>[
            SimpleDialogOption(
              child: Text("Capture Image with Camera", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: captureImageWithCamera,
            ),
            SimpleDialogOption(
              child: Text("Select Image from Gallery", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: pickImageFromGallery,
            ),
            SimpleDialogOption(
              child: Text("Cancel", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              onPressed: () =>Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }


  


  clearPostInfo(){
    locationtextEditingController.clear();
    descriptiontextEditingController.clear();
    setState(() {
      file = null;
    });

  }

  getCurrentUserLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placeMarks = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placeMarks[0];
    String addressinfo = '${placemark.subThoroughfare} ${placemark.thoroughfare}, ${placemark.subLocality} ${placemark.locality}, ${placemark.subAdministrativeArea} ${placemark.administrativeArea}, ${placemark.postalCode} ${placemark.country}';
    String specificaddress = '${placemark.locality}, ${placemark.country},';
    locationtextEditingController.text = specificaddress;
  }

  compressingPhoto() async {
    final tDirectory = await getTemporaryDirectory();
    final path = tDirectory.path;
    IMD.Image mImageFile = IMD.decodeImage(file.readAsBytesSync());
    final compressedImageFile = File('$path/img_$postID.jpg')..writeAsBytesSync(IMD.encodeJpg(mImageFile, quality: 90));
    setState(() {
      file = compressedImageFile;
    });
  }

  Future<String> uploadPhoto(mImagefile) async {
    StorageUploadTask storageUploadTask = storageReference.child("post_$postID.jpg").putFile(mImagefile);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    String downURL = await storageTaskSnapshot.ref.getDownloadURL();
    return downURL;
  }

  controlUploadSave() async {
    setState(() {
      up = true;
    });
    await compressingPhoto();
    String downURL = await uploadPhoto(file);
    savePostInfoToFirestore(url: downURL, location: locationtextEditingController.text, description: descriptiontextEditingController.text);
    locationtextEditingController.clear();
    descriptiontextEditingController.clear();

    setState(() {
      file = null;
      up = false;
      postID = Uuid().v4();
    });
  }


  savePostInfoToFirestore({String url, String location, String description}){
    postsReference.document(widget.gCurrentUser.id).collection("UsersPosts").document(postID).setData({
      "PostID" : postID,
      "OwnerID" : widget.gCurrentUser.id,
      "Timestamp" : timestamp,
      "Likes" : {},
      "Username" : widget.gCurrentUser.username,
      "Description" : description,
      "Location" : location,
      "URL" : url,
    });
  }

  displayUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: clearPostInfo,),
        title: Text("New Post", style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        actions: <Widget>[
          FlatButton(
              onPressed: up ? null : () => controlUploadSave(),
              child: Text("Share", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 16.0),),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          up ? linearProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file), fit: BoxFit.cover,)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),
          ListTile(
            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.gCurrentUser.url ),),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: descriptiontextEditingController,
                decoration: InputDecoration(
                  hintText: "Description.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: locationtextEditingController,
                decoration: InputDecoration(
                  hintText: "Location.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 220.0,
            height: 110.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
              color: Colors.green,
              label: Text("Select Venue from List", style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.arrow_downward, color: Colors.white,),
              onPressed: venues,
            ),
          )
        ],
      ),
    );
  }

  displayUploadFormScreen2(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: clearPostInfo,),
        title: Text("New Post", style: TextStyle(fontSize: 24.0, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
        actions: <Widget>[
          FlatButton(
            onPressed: up ? null : () => controlUploadSave(),
            child: Text("Share", style: TextStyle(color: Colors.lightGreenAccent, fontWeight: FontWeight.bold, fontSize: 16.0),),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 12.0),),
          ListTile(
            leading: CircleAvatar(backgroundImage: CachedNetworkImageProvider(widget.gCurrentUser.url ),),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: descriptiontextEditingController,
                decoration: InputDecoration(
                  hintText: "Description.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person_pin_circle, color: Colors.white, size: 36.0,),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white),
                controller: locationtextEditingController,
                decoration: InputDecoration(
                  hintText: "Location.",
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            width: 220.0,
            height: 110.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
              color: Colors.green,
              label: Text("Select Venue from List", style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.arrow_downward, color: Colors.white,),
              onPressed: venues,
            ),
          ),
          Container(
            width: 220.0,
            height: 60.0,
            alignment: Alignment.center,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
              color: Colors.green,
              label: Text("Upload Image", style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.arrow_upward, color: Colors.white,),
              onPressed: () => takeImage(context),
            ),
          ),
        ],
      ),
    );
  }


  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return file == null ? displayUploadFormScreen2() : displayUploadFormScreen();
    /*displayUploadFormScreen2();
    if(file==null)
      {
        return displayUploadFormScreen();
      }*/


  }
}

/*returnRooms() async {
  //var db = await openDatabase('class_schedule_4.db');
  //var databasesPath = await getDatabasesPath();
  /*print("he");
    print(databasesPath);
    print("fffffff");
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    print(documentsDirectory);
    print("pppppppppp");
    String dpath = path.join(databasesPath, 'class_schedule_4.db');*/
  String dpath = "C:/Users/hamza/Downloads/Compressed/buddies_gram/lib/pages/class_schedule_4";
  print( dpath);
  Database database = await openDatabase(dpath, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'create table room (RNumber text PRIMARY KEY, RoomType text, Capacity integer)');
      });
  await database.transaction((txn) async {
    int id1 = await txn.rawInsert(
        'insert into room Values ("C301", "Classroom", 50)');
    print('inserted1: $id1');
  });
  List<Map> list = await database.rawQuery('SELECT RNumber FROM room');
  print(list);
  roomsInDropDown();
}

roomsInDropDown() {
  void initState(){
    super.initState();
    list = [];
    DB.initialize().then((status){
      if(status) {
        DB.getData().then((listMap) {
          listMap.map((map) {
            print(map.toString());
            return getDropDownWidget(map);
          }).forEach ((dropDownItem) {
            list.add(dropDownItem);
          });
          setState(() {

          });
        });
      }
    });
  }


}

DropdownMenuItem<String> getDropDownWidget (Map<String, dynamic> map) {
  return DropdownMenuItem<String>(
    value: map['ITEM'],
    child: Text(map['ITEM']),
  );
}

  displayUploadScreen(){
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_photo_alternate, color: Colors.grey, size: 200.0,),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
              child: Text("Upload Image", style: TextStyle(color: Colors.white, fontSize: 20.0),),
              color: Colors.green,
              onPressed: () => takeImage(context)
            ),
          ),
        ],
      ),
    );

  }

  displayUploadScreen2(){
    return ListView(
      children: <Widget>[
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_photo_alternate, color: Colors.grey, size: 200.0,),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                    child: Text("Upload Image", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    color: Colors.green,
                    onPressed: () => takeImage(context)
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).accentColor.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
                    child: Text("Add Description", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    color: Colors.green,
                    onPressed: displayUploadFormScreen2,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
 */

