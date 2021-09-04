import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/WhatApp/imagescreen.dart';
import 'package:insta/WhatApp/videoscreen.dart';

class DashBoard extends StatefulWidget {


  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        ImageScreen(),
        VideoScreen(),
      ],
    );
  }
}
