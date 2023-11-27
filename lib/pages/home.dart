import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/models/user_model.dart';
import 'package:time_planner/time_planner.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/providers/schedule_provider.dart';
import 'package:myapp/models/class_model.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

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

class TimePicker extends StatefulWidget {
  String name;
  TimeOfDay time;
  final Function onTimeChanged;
  TimePicker(
      {super.key,
      required this.name,
      required this.time,
      required this.onTimeChanged});
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
            data: ThemeData.dark(),
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
        Text(widget.name,
            style: const TextStyle(
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
  final List<String> selectedDays;

  CustomDropDownMenu({Key? key, required this.selectedDays}) : super(key: key);

  @override
  _CustomDropDownMenuState createState() => _CustomDropDownMenuState();
}

class _CustomDropDownMenuState extends State<CustomDropDownMenu> {
  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Days',
          style: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            letterSpacing: 1.5,
            height: 1.0,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        MultiSelectDropDown(
          controller: _controller,
          onOptionSelected: (List<ValueItem> selectedOptions) {
            setState(() {
              widget.selectedDays.clear();
              widget.selectedDays.addAll(selectedOptions.map((e) => e.value!));
            });
          },
          options: const <ValueItem>[
            ValueItem(label: 'Monday', value: 'Monday'),
            ValueItem(label: 'Tuesday', value: 'Tuesday'),
            ValueItem(label: 'Wednesday', value: 'Wednesday'),
            ValueItem(label: 'Thursday', value: 'Thursday'),
            ValueItem(label: 'Friday', value: 'Friday'),
          ],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(
              wrapType: WrapType.wrap,
              backgroundColor: AppColors.buttonColor2,
              labelStyle: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 1.5,
                height: 1.0,
                color: Colors.white,
              )),
          dropdownHeight: 200,
          optionTextStyle: const TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            letterSpacing: 1.5,
            height: 1.0,
            color: Colors.black,
          ),
          borderRadius: 20,
          radiusGeometry: BorderRadius.circular(20),
          selectedOptionIcon: const Icon(
            Icons.check_circle,
            color: AppColors.themeColor,
          ),
          focusedBorderColor: Colors.black54,
          borderColor: Colors.grey,
          optionsBackgroundColor: Colors.white,
          hint: 'Select Days',
          hintColor: Colors.grey,
          hintStyle: TextStyle(color: Colors.grey[500]),
          selectedOptionBackgroundColor: AppColors.themeColor,
          showClearIcon: true,
        ),
      ],
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

class _Schedule extends ConsumerStatefulWidget {
  const _Schedule({Key? key}) : super(key: key);
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<_Schedule> {
  @override
  List<String> selectedDays = [];
  int minuteDuration = 90, daysDuration = 1;
  TimeOfDay startTime = TimeOfDay.now(), endTime = TimeOfDay.now();
  int day = 0;
  int startMinute = TimeOfDay.now().minute, startHour = TimeOfDay.now().hour;
  int endMinute = TimeOfDay.now().minute, endHour = TimeOfDay.now().hour;
  // void displayTaskInformation();

  String convertTimeOfDayToIso8601(TimeOfDay time,
      {int offsetHours = 0, int offsetMinutes = 0}) {
    DateTime now = DateTime.now();
    DateTime dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);

    DateTime dateTimeWithOffset =
        dateTime.add(Duration(hours: offsetHours, minutes: offsetMinutes));

    return dateTimeWithOffset.toIso8601String();
  }

  void onStartTimeChanged(TimeOfDay newTime) {
    setState(() {
      this.startTime = newTime;
      startMinute = newTime.minute;
      startHour = newTime.hour;
    });
  }

  void onEndTimeChanged(TimeOfDay newTime) {
    setState(() {
      this.endTime = newTime;
      endMinute = newTime.minute;
      endHour = newTime.hour;
    });
  }

  dynamic onDayChosen(int dayChosen) {
    day = dayChosen;
  }

  void onTaskCreate() async {
    TextEditingController nameController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController professorController = TextEditingController();

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
                      CustomDropDownMenu(selectedDays: selectedDays),
                      const SizedBox(
                        height: 40,
                      ),
                      TimePicker(
                        name: 'Start Time',
                        time: startTime,
                        onTimeChanged: onStartTimeChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TimePicker(
                        name: 'End Time',
                        time: endTime,
                        onTimeChanged: onEndTimeChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TaskField(
                          labelText: 'Professor',
                          name: 'Enter your professor\'s name',
                          controller: professorController,
                          icon: const Icon(
                            Icons.person,
                          )),
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
                          print("on pressed initated");
                          print("name: ${nameController.text}");

                          List<String> fullCourse =
                              ScheduleNotifier.stringSplit(nameController.text);
                          String subjectPrefix = fullCourse[0];
                          String courseNumber = fullCourse[1];

                          print(
                              "course name parsed: ${subjectPrefix} ${courseNumber} ");

                          List<String> location = ScheduleNotifier.stringSplit(
                              locationController.text);
                          String building = location[0];
                          String room = location[1];

                          print("location parsed: ${building} ${room}");

                          String? professor = professorController.text;

                          String? startingTime =
                              convertTimeOfDayToIso8601(startTime).toString();
                          String? endingTime =
                              convertTimeOfDayToIso8601(endTime).toString();

                          print(
                              "Starting Time: ${startingTime}\n Ending Time: ${endingTime} ");

                          ClassModel course = ClassModel(
                              subjectPrefix: subjectPrefix,
                              courseNumber: courseNumber,
                              catalogYear: '2023',
                              sectionNumber: '000',
                              start_time: startingTime,
                              end_time: endingTime,
                              building: building,
                              room: room,
                              map_uri: "www.google.com",
                              meetingDays: selectedDays,
                              professor: professor);

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
        tasks: ref
            .read(scheduleNotifierProvider.notifier)
            .convertCoursesToTasks(context),
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
