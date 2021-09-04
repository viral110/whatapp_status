import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:insta/WhatApp/viewphoto.dart';

final Directory _photoDir =
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!Directory('${_photoDir.path}').existsSync()) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Install WhatsApp\n',
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            "Your Friend's Status Will Be Available Here",
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      );
    } else {
      final imageList = _photoDir
          .listSync()
          .map((e) => e.path)
          .where((element) => element.endsWith('.jpg'))
          .toList(growable: false);
      print(imageList);
      if (imageList.length > 0) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 3,
            itemBuilder: (context, index) {
              final imagePath = imageList[index];
              return Material(
                elevation: 8.0,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewPhoto(imgPath: imagePath,),
                        ));
                  },
                  child: Hero(
                      tag: imagePath,
                      child: Image.file(
                        File(imagePath),
                        fit: BoxFit.cover,
                      )),
                ),
              );
            },
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            staggeredTileBuilder: (index) =>
                StaggeredTile.count(2, index.isEven ? 2 : 3),
          ),
        );
      }else{
        return Scaffold(
          body: Center(
            child: Container(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: const Text(
                  'Sorry, No Image Found!',
                  style: TextStyle(fontSize: 18.0),
                )),
          ),
        );
      }
    }
  }
}
