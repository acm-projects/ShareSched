import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:time_planner/time_planner.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/models/schedule.dart';
import 'package:myapp/models/course.dart';

final scheduleNotifierProvider =
    StateNotifierProvider<ScheduleNotifier, Schedule>(
        (ref) => ScheduleNotifier());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Schedule(),
    );
  }
}

class TaskField extends StatefulWidget {
  final String name;
  final String labelText;
  final TextEditingController controller;
  final Icon icon;

  TaskField(
      {super.key,
      required this.name,
      required this.labelText,
      required this.controller,
      required this.icon});

  _TaskFieldState createState() => _TaskFieldState();
}

class _TaskFieldState extends State<TaskField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.labelText,
          style: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            letterSpacing: 1.5,
            height: 1.0,
            color: Colors.white,
          )),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: FocusScope(
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                isFocused = hasFocus;
              });
            },
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: isFocused ? Colors.lightBlue[50] : Colors.white,
                hintText: widget.name,
                hintStyle: TextStyle(color: Colors.grey[500]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                ),
                prefixIcon: widget.icon,
                suffixIcon: widget.controller.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => widget.controller.clear(),
                      )
                    : null,
              ),
            ),
          ),
        ),
      )
    ]);
  }
}

class TimePicker extends StatefulWidget {
  TimeOfDay time;
  final Function onTimeChanged;
  TimePicker({super.key, required this.time, required this.onTimeChanged});
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  void _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: widget.time,
        initialEntryMode: TimePickerEntryMode.dial,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.dark(), // Set the brightness to dark
            child: child!,
          );
        });
    if (picked != null && picked != selectedTime) {
      setState(() {
        widget.time = picked;
      });

      widget.onTimeChanged(picked);
    }
  }

  Widget build(BuildContext build) {
    return Column(
      children: [
        const Text('Time',
            style: TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              letterSpacing: 1.5,
              height: 1.0,
              color: Colors.white,
            )),
        Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.themeColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () => _showTimePicker(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Pick Time',
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      )),
                ],
              ),
            ))
      ],
    );
  }
}

class AddCourseButton extends StatefulWidget {
  final Function onPressed;

  AddCourseButton({super.key, required this.onPressed});

  _AddCourseButtonState createState() => _AddCourseButtonState();
}

class _AddCourseButtonState extends State<AddCourseButton> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.themeColor.withOpacity(0.7),
            AppColors.themeColor,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minWidth: 300,
        height: 50,
        onPressed: () => widget.onPressed(),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Add Course',
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                letterSpacing: 1.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDropDownMenu extends StatefulWidget {
  final Function(int) onItemChosen;
  const CustomDropDownMenu({Key? key, required this.onItemChosen})
      : super(key: key);

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  String? selectedOption;
  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Day',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            letterSpacing: 1.5,
            height: 1.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        DropdownButton<String>(
          borderRadius: BorderRadius.circular(30),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          dropdownColor: AppColors.themeColor,
          value: selectedOption ?? days.first,
          onChanged: (String? value) {
            setState(() {
              selectedOption = value!;
            });
            widget.onItemChosen(days.indexOf(value!));
          },
          items: days.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(10),
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    letterSpacing: 1.5,
                    height: 1.0,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class CourseModal extends StatefulWidget {
  String? courseName;
  final String? professorName;
  double? professorRating;
  int? creditHours;
  CourseModal(
      {super.key,
      required this.courseName,
      this.professorName,
      this.professorRating,
      this.creditHours});

  _CourseModalState createState() => _CourseModalState();
}

class _CourseModalState extends State<CourseModal> {
  Widget build(BuildContext context) {
    return Dialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: DefaultTextStyle(
            style: const TextStyle(
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              letterSpacing: 1.5,
              height: 1.0,
              color: Colors.white,
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
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                      Row(
                        children: [
                          const Icon(Icons.book),
                          const SizedBox(width: 10),
                          Text('Course Name: ${widget.courseName}'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          Text('Professor: ${widget.professorName}'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          const SizedBox(width: 10),
                          Text('Professor Rating: ${widget.professorRating}'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 10),
                          Text('Credit Hours: ${widget.creditHours}'),
                        ],
                      )
                    ]))))));
  }
}

class _Schedule extends ConsumerStatefulWidget {
  const _Schedule({Key? key}) : super(key: key);
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<_Schedule> {
  @override
  String taskName = "", location = "";
  int minuteDuration = 90, daysDuration = 1;
  TimeOfDay selectedTime = TimeOfDay.now();
  int day = 0, minute = TimeOfDay.now().minute, hour = TimeOfDay.now().hour;
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
                        onPressed: () {
                          print(taskName + '\n');
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
                          print(selectedTime.toString());
                          print(
                              '${course.day}, ${course.hour}, ${course.minute}');
                          ref
                              .read(scheduleNotifierProvider.notifier)
                              .addCourse(course);
                          ref
                              .read(scheduleNotifierProvider.notifier)
                              .printCourses();
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
    ref.watch(scheduleNotifierProvider);
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
        tasks:
            ref.read(scheduleNotifierProvider.notifier).convertCoursesToTasks(),
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

class AddTaskButton extends StatelessWidget {
  final Function onPressed;
  const AddTaskButton({super.key, required this.onPressed});

  Widget build(BuildContext build) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor2,
          shape: const CircleBorder(),
          fixedSize: const Size(60.0, 60.0)),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
