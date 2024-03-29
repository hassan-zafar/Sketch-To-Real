import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fyp_sketch_to_real/Database/local_database.dart';
import 'package:fyp_sketch_to_real/config/collectionNames.dart';
import 'package:fyp_sketch_to_real/models/userModel.dart';
import 'package:fyp_sketch_to_real/tools/custom_toast.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  // Future<Stream<QuerySnapshot>> getproductData() async {
  //   return FirebaseFirestore.instance.collection(productCollection).snapshots();
  // }

  Future addUserInfoToFirebase(
      {@required UserModel userModel,
      @required String userId,
      @required email}) async {
    final Map<String, dynamic> userInfoMap = userModel.toMap();
    return userRef.doc(userId).set(userInfoMap).then((value) {
      String userModelString = json.encode(userInfoMap);
      UserLocalData().setUserModel(userModelString);
    }).catchError(
      (Object obj) {
        errorToast(message: obj.toString());
      },
    );
  }

  addNotification(
      {final String postId,
      final String notificationTitle,
      final String imageUrl,
      final String eachUserId,
      String eachUserToken,
      final String description}) async {
    String notificationsId = Uuid().v4();
    FirebaseFirestore.instance
        .collection("notifications")
        .doc(eachUserId)
        .collection("userNotifications")
        .doc(postId)
        .set({
      "notificationsId": notificationsId,
      "notificationTitle": notificationTitle,
      "description": description,
      "postId": postId,
      "timestamp": DateTime.now(),
      "token": eachUserToken,
      "imageUrl": imageUrl,
      "userId": currentUser.userId
    });
  }

  Future fetchUserInfoFromFirebase({@required String uid}) async {
    final DocumentSnapshot _user = await userRef.doc(uid).get();
    currentUser = UserModel.fromDocument(_user);
    Map userInfoMap = currentUser.toMap();
    String userModelString = json.encode(userInfoMap);
    UserLocalData().setUserModel(userModelString);
    isAdmin = currentUser.isAdmin;
  }
}
