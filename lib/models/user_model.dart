import 'package:get/get.dart';
import 'package:myapp/models/user.dart';

import 'class_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? password;
  String? avatarURL;
  Schedule? schedule;
  String? userDocID;
  List<UserModel>? friends;

  UserModel(
      {this.username,
      required this.email,
      this.password,
      this.avatarURL =
          "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg",
      this.schedule,
      this.userDocID,
      this.friends});

  toJson() {
    return {
      "Username": username,
      "Email": email,
      "Password": password,
      "AvatarURL": avatarURL,
      // Add other fields as needed
    };
  }

  static Future<UserModel?> fromEmail(String email) async {
    // Fetch the user document from Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("Users")
        .where("Email", isEqualTo: email)
        .limit(1)
        .get();

    if (snapshot.docs.isEmpty) {
      return null; // No user found for this email
    }

    var doc = snapshot.docs.first;
    var data = doc.data();
    var docID = doc.id;
    // Create a UserModel instance with the fetched data
    Schedule? sched = await fetchUserSchedule(docID);

    List<UserModel>? friends = await getFriendsModels(
        data['Friends'] != null ? List<String>.from(data['Friends']) : null);
    return UserModel(
        userDocID: docID,
        friends: friends,
        username: data['Username'],
        email: data['Email'],
        password: data['Password'],
        avatarURL: data['AvatarURL']?.isEmpty ?? true
            ? "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg"
            : data['AvatarURL'],
        schedule: sched);
  }

  static Future<List<UserModel>> getFriendsModels(
      List<String>? friendDocIDs) async {
    List<UserModel> friendsList = [];

    if (friendDocIDs == null || friendDocIDs.isEmpty) {
      return friendsList; // Return an empty list if there are no friend IDs
    }

    try {
      for (String docID in friendDocIDs) {
        DocumentSnapshot<Map<String, dynamic>> friendDoc =
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(docID)
                .get();
        Schedule sched = await fetchUserSchedule(docID);

        if (friendDoc.exists) {
          var data = friendDoc.data();
          if (data != null) {
            friendsList.add(UserModel(
              userDocID: docID,
              username: data['Username'],
              email: data['Email'],
              avatarURL: data['AvatarURL']?.isEmpty ?? true
                  ? "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg"
                  : data['AvatarURL'],

              schedule:
                  sched, // Adjust according to your Schedule class structure
            ));
          }
        }
      }
    } catch (e) {
      print("Error fetching friend data: $e");
      // You might want to handle the error more gracefully
    }

    return friendsList;
  }

  static Future<Schedule> fetchUserSchedule(String userDocID) async {
    print('Fetching schedule for user document ID: $userDocID');

    Schedule schedule = Schedule(id: userDocID, courses: []);

    final schedulesRef = FirebaseFirestore.instance.collection('Schedules');

    final classesSnapshot =
        await schedulesRef.doc(userDocID).collection('Classes').get();

    List<ClassModel> userClasses = [];

    for (var classDoc in classesSnapshot.docs) {
      var data = classDoc.data();
      // Assuming ClassModel has a constructor that takes a Map
      var classModel = ClassModel.fromJson(data);
      userClasses.add(classModel);
    }

    // Assign the retrieved classes to the schedule
    schedule.courses = userClasses;

    if (schedule.courses.isEmpty) {
      return Schedule(id: '1', courses: []);
    }

    return schedule;
  }
}

class Schedule {
  final String id;
  List<ClassModel> courses;

  Schedule({required this.id, required this.courses});

  Schedule copyWith({String? id, List<ClassModel>? courses}) {
    return Schedule(
      id: id ?? this.id,
      courses: courses ?? this.courses,
    );
  }

  void printCourses() {
    for (int i = 0; i < courses.length; ++i) {
      print("Course: ${courses[i].subjectPrefix} ${courses[i].courseNumber}");
    }
  }
}
