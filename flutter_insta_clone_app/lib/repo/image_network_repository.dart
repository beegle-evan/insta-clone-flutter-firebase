import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_insta_clone_app/repo/helper/images_helper.dart';

class ImageNetworkRepository {
  Future<void> uploadImageNCreateNewPost(File originImage, {@required String postKey}) async {
    try {
      // isolate를 이용하여, 작업을 다른 쪽에 넘겨서 처리,, thread같이..
      final File resized = await compute(getResizedImage, originImage);

      final StorageReference storageReference = FirebaseStorage().ref().child(_getImagePathByPostKey(postKey));
      final StorageUploadTask uploadTask = storageReference.putFile(resized);
      return uploadTask.onComplete;
      //await Future.delayed(Duration(seconds: 3));
    } catch (e) {
      print(e);
      return null;
    }
  }

  // 이 key를 통해서 스토리지를 접근하고, 저장하는 것들을 수행한다.
  String _getImagePathByPostKey(String postKey) => 'post/$postKey/post.jpg';
}

ImageNetworkRepository imageNetworkRepository = ImageNetworkRepository();
