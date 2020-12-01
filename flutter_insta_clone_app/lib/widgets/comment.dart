import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/widgets/rounded_avatar.dart';

class Comment extends StatelessWidget {
  final bool showImage;
  final String username;
  final String text;
  final DateTime dateTime;

  Comment({
    Key key, this.showImage=true, @required this.username,@required this.text, this.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showImage)
          RoundedAvatar(size: 24),
        if (showImage)
          SizedBox(width: common_xxs_gap,)
        ,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text: TextSpan(
                children: <TextSpan>[
                  TextSpan( // TextSpan의 경우, Theme의 primaryColor를 따라가므로, color를 따로 지정해줘야 함.
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold, color:Colors.black87)
                  ),
                  TextSpan(text:'   '),
                  TextSpan(text: text, style: TextStyle(color: Colors.black87)),
                ]
            ),
            ),
            if (dateTime != null)
              Text(
                dateTime.toIso8601String(),
                style: TextStyle(color: Colors.grey[400], fontSize: 10),
              )
          ],
        ),
      ],
    );
  }
}
