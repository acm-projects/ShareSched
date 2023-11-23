import 'package:myapp/models/schedule.dart';

class UserModel {
  //final String? id;
  final String? id;
  final String username;
  final String email;
  final String password;
  final String? avatarURL;
  Schedule schedule;

  UserModel({
    //required this.id,
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.avatarURL,
    required this.schedule,
  });

  toJson() {
    return {
      "Username": username,
      "Email": email,
      "Password": password,
    };
  }
}
