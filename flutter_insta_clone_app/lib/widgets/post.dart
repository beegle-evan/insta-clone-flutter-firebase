import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/constants/screen_size.dart';
import 'package:flutter_insta_clone_app/repo/image_network_repository.dart';
import 'package:flutter_insta_clone_app/widgets/comment.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';
import 'package:flutter_insta_clone_app/widgets/rounded_avatar.dart';

class Post extends StatelessWidget {
  final int index;

  Post(
    this.index, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader(),
        _postImage(),
        _postActions(),
        _postLikes(),
        _postCaption(),
      ],
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '120000 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(icon: ImageIcon(AssetImage('assets/images/bookmark.png')), color: Colors.black87, onPressed: null),
        IconButton(icon: ImageIcon(AssetImage('assets/images/comment.png')), color: Colors.black87, onPressed: null),
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/direct_message.png')), color: Colors.black87, onPressed: null),
        Spacer(), // IconButton을 차지하고 나머지 공간을 spacer가 차지
        IconButton(
            icon: ImageIcon(AssetImage('assets/images/heart_selected.png')), color: Colors.black87, onPressed: null)
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
            color: Colors.black87,
          ),
        )
      ],
    );
  }

  Widget _postImage() {
    Widget progress = MyProgressIndicator(
      containerSize: size.width,
    );

    return FutureBuilder<dynamic>(
        future: imageNetworkRepository.getPostImageUrl("postkey"),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return CachedNetworkImage(
              imageUrl: 'https://picsum.photos/id/$index/200/200',
              placeholder: (BuildContext context, String url) {
                return progress;
              },
              imageBuilder: (BuildContext context, ImageProvider imageProvider) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      decoration: BoxDecoration(image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
                );
              },
            );
          else
            return progress;
        });
  }

  Widget _postCaption() {
    // 글 안에 다양한 폰트와 글자들이 사용될 경우 RichText를 사용
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: common_gap,
        vertical: common_xxs_gap,
      ),
      child: Comment(
        showImage: false,
        username: 'testingUser',
        text: 'I have money!!!!',
      ),
    );
  }
}
