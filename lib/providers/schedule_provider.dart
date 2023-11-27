import 'package:myapp/models/class_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
import 'package:time_planner/time_planner.dart';
import 'package:flutter/material.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/custom_widgets.dart';
import 'package:myapp/models/course_modal.dart';

class ScheduleNotifier extends StateNotifier<Schedule> {
  ScheduleNotifier() : super(Schedule(id: "123", courses: []));

  void addCourse(ClassModel course) {
    // Create a new instance of Schedule with the updated courses list
    state = state.copyWith(courses: List.from(state.courses)..add(course));
    print('Added a course:  ${course.subjectPrefix} ${course.courseNumber}');
  }

  void printCourses() {
    print("Printing courses");

    for (int i = 0; i < state.courses.length; ++i) {
      print(
          'Course $i:  ${state.courses[i].subjectPrefix} ${state.courses[i].courseNumber}  \n');
    }
  }

  List<TimePlannerTask> convertCoursesToTasks(BuildContext context) {
    print("Conversion started");
    List<TimePlannerTask> tasks = [];
    for (int i = 0; i < state.courses.length; ++i) {
      String? courseName =
          '${state.courses[i].subjectPrefix} ${state.courses[i].courseNumber}';
      print('Course name: ${courseName}\n');
      String? location =
          '${state.courses[i].building} ${state.courses[i].room}';

      String? professorName = '${state.courses[i].professor}';
      print('Location: ${location}\n');
      List<int> days = convertDayToInt(state.courses[i].meetingDays);
      TimeOfDay startingTime = convertStringToTime(state.courses[i].start_time);
      print('Starting time: ${startingTime.hour}: ${startingTime.minute}');
      int minuteDuration = computeTimeDifferenceInMinutes(
          state.courses[i].start_time, state.courses[i].end_time);
      print('Minute duration: ${minuteDuration}');
      for (int i = 0; i < days.length; ++i) {
        tasks.add(TimePlannerTask(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CourseModal(
                      courseName: courseName,
                      professorName: professorName,
                      professorRating: 3,
                      creditHours: 3,
                    );
                  });
            },
            minutesDuration: minuteDuration,
            dateTime: TimePlannerDateTime(
                day: days[i],
                hour: startingTime.hour,
                minutes: startingTime.minute),
            color: AppColors.getRandomColor(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(text: courseName),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomText(text: professorName),
                  const SizedBox(
                    height: 6,
                  ),
                  CustomText(text: location),
                  const SizedBox(
                    height: 6,
                  ),
                ])));
      }
    }
    return tasks;
  }

  static TimeOfDay convertStringToTime(String? string) {
    String timePart = string!.substring(11, 16);

    List<String> timeParts = timePart.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    TimeOfDay time = TimeOfDay(hour: hour, minute: minute);

    print('${time.hour}: ${time.minute}');

    return time;
  }

  static List<int> convertDayToInt(List<String>? days) {
    List<int> daysList = [];
    for (int i = 0; i < days!.length; ++i) {
      switch (days[i]) {
        case 'Monday':
          daysList.add(0);
          break;
        case 'Tuesday':
          daysList.add(1);
          break;
        case 'Wednesday':
          daysList.add(2);
          break;
        case 'Thursday':
          daysList.add(3);
          break;
        case 'Friday':
          daysList.add(4);
          break;
      }
    }
    return daysList;
  }

  static int computeTimeDifferenceInMinutes(String? start, String? end) {
    DateTime startingTime = DateTime.parse(start!);
    DateTime endingTime = DateTime.parse(end!);

    Duration timeDifference = endingTime.difference(startingTime);

    return timeDifference.inMinutes;
  }

  static List<String> stringSplit(String string) {
    print("Splitting string.");
    if (!string.contains(' ')) return [string, ''];

    return string.split(' ');
  }

  List<List<List<String?>>> getCourseTimes() {
    List<List<String?>> monday = [],
        tuesday = [],
        wednesday = [],
        thursday = [],
        friday = [];
    for (int i = 0; i < state.courses.length; ++i) {
      for (int j = 0; j < state.courses[i].meetingDays!.length; ++j) {
        String? day = (state.courses[i].meetingDays?[j]);
        List<String?> timeArray = [
          state.courses[i].start_time,
          state.courses[i].end_time
        ];
        switch (day) {
          case 'Monday':
            monday.add(timeArray);
            break;
          case 'Tuesday':
            tuesday.add(timeArray);
            break;
          case 'Wednesday':
            wednesday.add(timeArray);
            break;
          case 'Thursday':
            thursday.add(timeArray);
            break;
          case 'Friday':
            friday.add(timeArray);
            break;
        }
      }
    }
    return [monday, tuesday, wednesday, thursday, friday];
  }
}
