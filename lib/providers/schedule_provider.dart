import 'package:myapp/models/course.dart';
import 'package:myapp/models/schedule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_planner/time_planner.dart';
import 'package:flutter/material.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/pages/custom_widgets.dart';

class ScheduleNotifier extends StateNotifier<Schedule> {
  ScheduleNotifier() : super(Schedule(id: "123", courses: []));

  void addCourse(Course course) {
    // Create a new instance of Schedule with the updated courses list
    state = state.copyWith(courses: List.from(state.courses)..add(course));
    print('Added a course:  ${course.name}');
  }

  void printCourses() {
    for (int i = 0; i < state.courses.length; ++i) {
      print('Course $i:  ${state.courses[i].name}');
    }
  }

  List<TimePlannerTask> convertCoursesToTasks() {
    List<TimePlannerTask> tasks = [];
    for (int i = 0; i < state.courses.length; ++i) {
      tasks.add(TimePlannerTask(
          color: AppColors.getRandomColor(),
          dateTime: TimePlannerDateTime(
              day: state.courses[i].day,
              hour: state.courses[i].hour,
              minutes: state.courses[i].minute),
          minutesDuration: state.courses[i].minuteDuration,
          daysDuration: state.courses[i].daysDuration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(text: state.courses[i].name),
              const SizedBox(
                height: 6,
              ),
              CustomText(text: state.courses[i].location),
              const SizedBox(
                height: 6,
              ),
            ],
          )));
    }
    return tasks;
  }
}
