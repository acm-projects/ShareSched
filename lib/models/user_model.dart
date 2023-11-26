import 'package:myapp/models/schedule.dart';

class UserModel {
  final String? uid;
  final String? id;
  final String username;
  final String email;
  final String password;
  final String? avatarURL;
  final Schedule? schedule;
  final List<String> friends; // Add a list of friends

  const UserModel({
    this.uid,
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.avatarURL,
    this.schedule,
    this.friends = const [], // Initialize friends as an empty list by default
  });

  Map<String, dynamic> toJson() {
    return {
      "Username": username,
      "Email": email,
      "Password": password,
      "AvatarURL": avatarURL,
      "Schedule": schedule,
      "Friends": friends, // Include the list of friends in the JSON representation
    };
  }
}

class Schedule {
  String id;
  List<String> courses;

  Schedule({required this.id, required this.courses});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courses': courses,
      // Add other properties of Schedule if necessary
    };
  }
}
