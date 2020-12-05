import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_insta_clone_app/constants/firestore_keys.dart';
import 'package:flutter_insta_clone_app/models/firestore/user_model.dart';
import 'package:flutter_insta_clone_app/repo/helper/transformers.dart';

class UserNetworkRepository with Transformers {
  // Future<void> sendData() {
  //   return Firestore.instance.collection('Users').document('123123123').setData(
  //     {'email': 'testing@google.com', 'username': 'myUserName'},
  //   );
  // }
  //
  // void getData() {
  //   Firestore.instance.collection('Users').document('123123123').get().then((docSnapshot) => print(docSnapshot.data));
  // }

  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference userRef = Firestore.instance.collection(COLLECTION_USERS).document(userKey);

    DocumentSnapshot snapshot = await userRef.get();
    if (!snapshot.exists) {
      return await userRef.setData(UserModel.getMapForCreateUser(email));
    }
  }

  Stream<UserModel> getUserModelStream(String userKey) {
    return Firestore.instance.collection(COLLECTION_USERS).document(userKey).snapshots().transform(toUser);
  }

  Stream<List<UserModel>> getAllUsersWithoutMe() {
    return Firestore.instance.collection(COLLECTION_USERS).snapshots().transform(toUsersExceptMe);
  }
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
