import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/models/schedule.dart';

class UserModel {
  //final String? id;
  final String? id;
  final String username;
  final String email;
  final String password;
  final String? avatarURL;
  Schedule schedule;
  final String userDocID;
  UserModel({
    //required this.id,
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatarURL,
    required this.schedule,
    this.userDocID = "",
  });

  toJson() {
    return {
      "Username": username,
      "Email": email,
      "Password": password,
    };
  }
}
