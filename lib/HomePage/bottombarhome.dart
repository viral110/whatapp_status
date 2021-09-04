import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/HomePage/homewhatsapp.dart';
import 'package:insta/WhatApp/imagescreen.dart';

class BottomBarHome extends StatefulWidget {


  @override
  _BottomBarHomeState createState() => _BottomBarHomeState();
}

class _BottomBarHomeState extends State<BottomBarHome> {
  int _selectedIndex = 0;

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  List _pages = [
    HomeWhatApp(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "WhatApp"),
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Insta"),
        ],
      ),
    );
  }
}
