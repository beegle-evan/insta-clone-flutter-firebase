import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_insta_clone_app/constants/firestore_keys.dart';
import 'package:flutter_insta_clone_app/models/firestore/user_model.dart';
import 'package:local_image_provider/local_album.dart';

class UserNetworkRepository {
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
}

UserNetworkRepository userNetworkRepository = UserNetworkRepository();
