import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/WhatApp/dashboard.dart';

class HomeWhatApp extends StatefulWidget {
  @override
  _HomeWhatAppState createState() => _HomeWhatAppState();
}

class _HomeWhatAppState extends State<HomeWhatApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatApp status Saver"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              icon: Icon(Icons.lightbulb_outline),
              onPressed: () {
                AdaptiveTheme.of(context).toggleThemeMode();
              }),
          PopupMenuButton<String>(
            onSelected: choiceAction,
            itemBuilder: (BuildContext context) {
              return Constants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(tabs: [
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'IMAGES',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12.0),
            child: const Text(
              'VIDEOS',
            ),
          ),
        ]),
      ),
      body: DashBoard(),
    );
  }

  void choiceAction(String choice) {
    if (choice == Constants.about) {
      print('About App');
    } else if (choice == Constants.rate) {
      print('Rate App');
    } else if (choice == Constants.share) {
      print('Share with friends');
    }
  }

}

class Constants {
  static const String about = 'About App';
  static const String rate = 'Rate App';
  static const String share = 'Share with friends';

  static const List<String> choices = <String>[about, rate, share];
}