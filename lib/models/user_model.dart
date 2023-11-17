import 'schedule.dart';

class UserModel {
  final String? id;
  final String email;
  final String username;
  final String password;
  final String? avatarURL;
  Schedule schedule;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.schedule,
    required this.password,
    required this.avatarURL,
  });

  toJson() {
    return {
      "Email": email,
      "Password": password,
    };
  }
}
