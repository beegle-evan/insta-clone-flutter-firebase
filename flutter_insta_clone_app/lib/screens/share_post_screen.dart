import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/constants/screen_size.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SharePostScreen extends StatelessWidget {
  final File imageFile;
  final String postKey;

  SharePostScreen(
    this.imageFile, {
    Key key,
    @required this.postKey,
  }) : super(key: key);

  List<String> _tagsItems = ["apple", "orange", "banana", "graph", "watermelon"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "Share",
              textScaleFactor: 1.4,
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _captionWidthImage(),
          _divider,
          _sectionButton('Tag Poeple'),
          _divider,
          _sectionButton('Add Location'),
          Tags(
            horizontalScroll: true,
            heightHorizontalScroll: 30,
            itemCount: _tagsItems.length,
            itemBuilder: (index) => ItemTags(
              title: _tagsItems[index],
              index: index,
              activeColor: Colors.grey[200],
              textActiveColor: Colors.black87,
              borderRadius: BorderRadius.circular(4),
              elevation: 2,
              splashColor: Colors.grey[800],
              highlightColor: Colors.red,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }

  Divider get _divider => Divider(
        color: Colors.grey[300],
        thickness: 1,
        height: 1,
      );

  ListTile _sectionButton(String title) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
      trailing: Icon(Icons.navigate_next),
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: common_gap),
    );
  }

  ListTile _captionWidthImage() {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: common_xxs_gap, horizontal: common_xxs_gap),
      leading: Image.file(
        imageFile,
        width: size.width / 6,
        height: size.width / 6,
        fit: BoxFit.cover,
      ),
      title: TextField(
        decoration: InputDecoration(hintText: 'Write a caption...', border: InputBorder.none),
      ),
    );
  }
}
