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
    Schedule sched = await fetchUserSchedule(docID);

    List<UserModel> friends = await getFriendsModels(
        data['Friends'] != null ? List<String>.from(data['Friends']) : null);
    return UserModel(
        userDocID: docID,
        friends: friends,
        username: data['Username'],
        email: data['Email'],
        password: data['Password'],
        avatarURL: data['AvatarURL'] ??
            "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg",
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
              avatarURL: data['AvatarURL'] ??
                  "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg",
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

    try {
      // Access the 'Classes' subcollection of the user's schedule
      QuerySnapshot<
          Map<String,
              dynamic>> classesSnapshot = await FirebaseFirestore.instance
          .collection('Schedules') // Your main schedules collection
          .doc(userDocID) // The document ID for the user's schedule
          .collection(
              'Classes') // The subcollection under the user's schedule document
          .get();

      // Process all the classes in the subcollection
      List<ClassModel> courses = classesSnapshot.docs
          .map((doc) => ClassModel.fromJson(doc.data()))
          .toList();

      if (courses.isNotEmpty) {
        schedule = Schedule(id: userDocID, courses: courses);
        print(
            'Successfully fetched ${courses.length} classes for user document ID: $userDocID');
      } else {
        print(
            'No classes found in the Classes subcollection for user document ID: $userDocID');
      }
    } catch (e) {
      print(
          'Error fetching Classes subcollection for user document ID $userDocID: $e');
      // Handle the error appropriately
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
