import 'package:flutter/material.dart';

AppBar header(context, {bool isAppTitle = false, String sTitle, dbb = false, String strTitle}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    automaticallyImplyLeading: dbb ? false : true,
    title: Text(
      isAppTitle ? "FASTAccess" : sTitle ,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "Signatra" : "",
        fontSize: isAppTitle ? 45.0 : 22.0,
      ),
      overflow: TextOverflow.ellipsis,
    ),
    centerTitle: true,
    backgroundColor: Theme.of(context).accentColor,
  );
}
