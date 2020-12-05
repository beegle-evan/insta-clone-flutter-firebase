import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_insta_clone_app/repo/helper/images_helper.dart';

class ImageNetworkRepository {
  Future<void> uploadImageNCreateNewPost(File originImage) async {
    try {
      // isolate를 이용하여, 작업을 다른 쪽에 넘겨서 처리,, thread같이..
      final File resized = await compute(getResizedImage, originImage);
      originImage.length().then((value) => print('original image size: $value'));
      resized.length().then((value) => print('resized image size: $value'));
    } catch (e) {}
  }
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
