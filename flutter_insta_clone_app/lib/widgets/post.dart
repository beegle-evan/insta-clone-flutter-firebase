import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';

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
      ],
    );
  }
  Widget _postHeader() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(common_xxs_gap),
          child: ClipOval( // child를 동그랗게 감싸줌
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/100',
              width: avatar_size,
              height: avatar_size,
            ),
          ),
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
