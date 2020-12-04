import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_insta_clone_app/constants/common_size.dart';
import 'package:flutter_insta_clone_app/models/gallery_state.dart';
import 'package:flutter_insta_clone_app/screens/share_post_screen.dart';
import 'package:local_image_provider/device_image.dart';
import 'package:local_image_provider/local_image.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyGallery extends StatefulWidget {
  @override
  _MyGalleryState createState() => _MyGalleryState();
}

class _MyGalleryState extends State<MyGallery> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryState>(builder: (BuildContext context, GalleryState galleryState, Widget child) {
      return GridView.count(
        crossAxisCount: 3,
        children: getImages(context, galleryState),
      );
    });
  }

  List<Widget> getImages(BuildContext context, GalleryState galleryState) {
    return galleryState.images
        .map(
          (localImage) => InkWell(
            onTap: () async {
              Uint8List bytes = await localImage.getScaledImageBytes(galleryState.localImageProvider, 0.3);
              final String timerInMilli = DateTime.now().millisecondsSinceEpoch.toString();
              try {
                final path = join((await getTemporaryDirectory()).path, '$timerInMilli.png');
                File imageFile = File(path)..writeAsBytesSync(bytes); // .. 하면 File method를 실행한 결과에 다음 메소드를 실행한다

                Navigator.of(context).push(MaterialPageRoute(builder: (_) => SharePostScreen(imageFile)));
              } catch (e) {}
            },
            child: Padding(
              padding: const EdgeInsets.all(common_xxxxs_gap),
              child: Image(
                image: DeviceImage(localImage, scale: 0.1),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
        .toList();
  }

  // Future<Uint8List> localImageToBytes(GalleryState galleryState, LocalImage localImage) {
  //   return localImage.getScaledImageBytes(galleryState.localImageProvider, 0.3);
  // }
}
