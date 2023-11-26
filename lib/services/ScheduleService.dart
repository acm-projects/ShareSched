import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  static Future<List<Map<String, dynamic>>> fetchCourseData(String userId) async {
    // Fetch course data from Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('courses')
        .get();

    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  static List<String> convertCourseData(List<Map<String, dynamic>> courses) {
    return courses
        .map((course) =>
            '${course['startTime']} - ${course['endTime']}') // Adjust these field names based on your Firestore structure
        .toList();
  }

  // Other scheduling-related methods (findCommonFreeTimes, printCommonFreeTimes) can also be moved here
}
