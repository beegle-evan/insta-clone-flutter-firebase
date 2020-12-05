import 'package:flutter_insta_clone_app/models/firestore/user_model.dart';

String getNewPostKey(UserModel userModel) => "${DateTime.now().millisecondsSinceEpoch}_${userModel.userKey}";
