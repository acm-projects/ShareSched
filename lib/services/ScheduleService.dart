import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TimeRange {
  DateTime start;
  DateTime end;

  TimeRange(this.start, this.end);

  static TimeRange fromString(String range) {
    List<String> parts = range.split(' - ');
    DateTime start = parseTime(parts[0]);
    DateTime end = parseTime(parts[1]);
    return TimeRange(start, end);
  }

  static DateTime parseTime(String time) {
    final format = DateFormat('hh:mm a');
    DateTime dateTime = format.parse(time);
    return DateTime(2023, 1, 1, dateTime.hour, dateTime.minute);
  }
}

Future<List<Map<String, dynamic>>> fetchCourseData(String userId) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .collection('courses')
      .get();

  return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
}

List<String> convertCourseData(List<Map<String, dynamic>> courses) {
  return courses
      .map((course) =>
          '${course['startTime']} - ${course['endTime']}') // Adjust these field names based on your Firestore structure
      .toList();
}

List<TimeRange> findCommonFreeTimes(List<TimeRange> schedules) {
  schedules.sort((a, b) => a.start.compareTo(b.start));

  List<TimeRange> commonFreeTimes = [];
  DateTime currentEndTime = TimeRange.parseTime("08:00 AM");

  for (TimeRange schedule in schedules) {
    DateTime scheduleStartTime = schedule.start;
    DateTime scheduleEndTime = schedule.end;

    if (currentEndTime.isBefore(scheduleStartTime)) {
      commonFreeTimes.add(TimeRange(currentEndTime, scheduleStartTime));
    }

    currentEndTime = scheduleEndTime;
  }

  return commonFreeTimes;
}

void printCommonFreeTimes(List<TimeRange> commonFreeTimes) {
  print("Common Free Times:");
  for (var freeTime in commonFreeTimes) {
    print("Start Time - ${freeTime.start}, End Time - ${freeTime.end}");
  }
}