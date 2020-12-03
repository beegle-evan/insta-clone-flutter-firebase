import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/constants/screen_size.dart';
import 'package:flutter_insta_clone_app/widgets/my_progress_indicator.dart';

class TakePhoto extends StatefulWidget {
  const TakePhoto({
    Key key,
  }) : super(key: key);

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  CameraController _controller;
  Widget _progress = MyProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          return Column(
            children: [
              Container(
                width: size.width,
                height: size.width,
                color: Colors.black,
                child: (snapshot.hasData) ? _getPreview(snapshot.data) : _progress,
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
        });
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

  Widget _getPreview(List<CameraDescription> cameras) {
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    // CameraController를 초기화해야하는데, 초기화하는 것도 시간이 걸리기 때문에 FutureBuilder로 초기화 끝나는 것을 기다려 줘야 함.
    // 그리고 리턴되는 snapshot에는 void 타입으로 값이 없기때문에, hasData를 체크하면 안되고,
    // ConnectionState를 통해 처리가 끝났는지 체크해야 한다.
    return FutureBuilder(
      future: _controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ClipRect(
            child: OverflowBox(
              alignment: Alignment.center,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                    width: size.width,
                    height: size.height / _controller.value.aspectRatio,
                    child: CameraPreview(_controller)),
              ),
            ),
          );
          //return CameraPreview(_controller);
        } else {
          return _progress;
        }
      },
    );
  }
}
