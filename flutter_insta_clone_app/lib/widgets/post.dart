import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';
import 'package:flutter_insta_clone_app/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;
  Size size;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size; // 화면의 크기를 가져옴
    }

    return Column(
      children: [
        _postHeader(),
        _postImage(),
        _postActions()
      ],
    );
  }

  Row _postActions() {
    return Row(
        children: <Widget>[
          IconButton(
              icon: ImageIcon(AssetImage('assets/images/bookmark.png')),
              color: Colors.black87,
              onPressed: null
          ),
          IconButton(
              icon: ImageIcon(AssetImage('assets/images/comment.png')),
              color: Colors.black87,
              onPressed: null
          ),
          IconButton(
              icon: ImageIcon(AssetImage('assets/images/direct_message.png')),
              color: Colors.black87,
              onPressed: null
          ),
          Spacer(), // IconButton을 차지하고 나머지 공간을 spacer가 차지
          IconButton(
              icon: ImageIcon(AssetImage('assets/images/heart_selected.png')),
              color: Colors.black87,
              onPressed: null
          )
        ],
      );
  }

  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: RoundedAvatar(),
        ),
        Text('username'),
        IconButton(
          onPressed: null,
          icon: Icon(
            Icons.more_horiz,
            color:Colors.black87,
          ),
        )
      ],
    );
  }

  CachedNetworkImage _postImage() {
    return CachedNetworkImage(
        imageUrl: 'https://picsum.photos/id/$index/200/200',
        placeholder: (BuildContext context, String url) {
          return MyProgressIndicator(
            containerSize: size.height,
          );
        },
        imageBuilder: (BuildContext context, ImageProvider imageProvider) {
          return AspectRatio(
            aspectRatio: 1,
            child: Container(decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
          );
        },
      );
  }
}

