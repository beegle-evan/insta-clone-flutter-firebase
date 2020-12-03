import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/constants/screen_size.dart';

class TakePhoto extends StatelessWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.width,
          color: Colors.black,
        ),
        Expanded(
          child: OutlineButton(
            onPressed: () {},
            shape: CircleBorder(),
            borderSide: BorderSide(color: Colors.black12, width: 20),
          ),
        ),
      ],
    );
  }

  InkWell _build_btn_by_InkWell() {
    return InkWell(
      // InkWell로 감싸서, 클릭할 수 있도록 변경 가능하다
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(common_s_gap),
        child: Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(color: Colors.black12, width: 20),
            ),
          ),
        ),
      ),
    );
  }
}
