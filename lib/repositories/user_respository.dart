import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/models/user.dart';
import 'package:myapp/models/user_model.dart';

String userDocID = "";

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final newDocRef = DocumentReference;

  createUser(UserModel user) async {
    DocumentReference newDocRef =
        await _db.collection("Users").add(user.toJson());
    userDocID = newDocRef.id;
    print(newDocRef.id);
  }

  // Future<UserModel> getUser(String uid) async {
  //   var doc = await _db.collection("Users").doc(uid).get();;
  // }

  Future<String> getUserDocId() async {
    return userDocID;
  }
}
