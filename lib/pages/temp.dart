
/*import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class _Schedule extends ConsumerStatefulWidget {
  const _Schedule({super.key});

  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<_Schedule> {
  @override
  String taskName = "", location = "";
  int day = 0, minute = 0, hour = 0;
  int minuteDuration = 90, daysDuration = 1;
  TimeOfDay selectedTime = TimeOfDay.now();
  List<TimePlannerTask> tasks = [];
  // void displayTaskInformation();

  void onTimeChanged(TimeOfDay newTime) {
    setState((() => selectedTime = newTime));
    minute = selectedTime.minute;
    hour = selectedTime.hour;
  }

  dynamic onDayChosen(int dayChosen) {
    day = dayChosen;
  }

  void onTaskTapped() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CourseModal(
            courseName: 'Linear Algebra',
            professorName: 'Luis Felipe Pereira',
            professorRating: 3,
            creditHours: 3,
          );
        });
  }

  void onTaskCreate() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.themeColor,
                    Colors.black,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TaskField(
                        labelText: 'Course Name',
                        name: 'Enter your course name',
                        controller: nameController,
                        icon: const Icon(Icons.edit),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomDropDownMenu(onItemChosen: onDayChosen),
                      const SizedBox(
                        height: 40,
                      ),
                      TimePicker(
                        time: selectedTime,
                        onTimeChanged: onTimeChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TaskField(
                          labelText: 'Location',
                          name: 'Enter the course location',
                          controller: locationController,
                          icon: const Icon(
                            Icons.location_on,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      AddCourseButton(
                        onPressed: () => {
                          print(taskName + '\n'),
                          setState(() {
                            taskName = nameController.text;
                            location = locationController.text;
                            Course course = Course(
                                name: taskName,
                                location: location,
                                day: day,
                                hour: hour,
                                minute: minute,
                                minuteDuration: minuteDuration,
                                daysDuration: daysDuration);

                            tasks.add(
                              TimePlannerTask(
                                  onTap: onTaskTapped,
                                  color: AppColors.getRandomColor(),
                                  dateTime: TimePlannerDateTime(
                                      day: course.day,
                                      hour: course.hour,
                                      minutes: course.minute),
                                  minutesDuration: course.minuteDuration,
                                  daysDuration: course.daysDuration,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(text: course.name),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      CustomText(text: course.location),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                    ],
                                  )),
                            );
                          }),
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddTaskButton(onPressed: onTaskCreate),
      body: TimePlanner(
        startHour: 8,
        endHour: 20,
        headers: const [
          TimePlannerTitle(
              title: 'Monday',
              titleStyle: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700)),
          TimePlannerTitle(
              title: 'Tuesday',
              titleStyle: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700)),
          TimePlannerTitle(
              title: 'Wednesday',
              titleStyle: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700)),
          TimePlannerTitle(
              title: 'Thursday',
              titleStyle: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700)),
          TimePlannerTitle(
              title: 'Friday',
              titleStyle: TextStyle(
                  color: AppColors.primaryTextColor,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w700)),
        ],
        tasks: tasks,
        style: TimePlannerStyle(
            horizontalTaskPadding: BorderSide.strokeAlignCenter,
            backgroundColor: Colors.black,
            dividerColor: const Color.fromRGBO(53, 51, 205, 1),
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        use24HourFormat: false,
      ),
    );
  }
}
*/