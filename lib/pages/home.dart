import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'package:myapp/colors/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void addTaskButtonPressed() {
    print('Pressed add task button');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Schedule(),
      floatingActionButton: AddTaskButton(
        onPressed: addTaskButtonPressed,
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final double letterSpacing;

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize = 12.0,
    this.color = AppColors.primaryTextColor,
    this.fontWeight = FontWeight.bold,
    this.letterSpacing = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Quicksand',
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  List<TimePlannerTask> tasks = [
    TimePlannerTask(
        // background color for task
        color: AppColors.mathColor,

        // day: Index of header, hour: Task will be begin at this hour
        // minutes: Task will be begin at this minutes
        dateTime: TimePlannerDateTime(day: 1, hour: 14, minutes: 30),
        // Minutes duration of task
        minutesDuration: 90,
        // Days duration of task (use for multi days task)
        daysDuration: 1,
        onTap: () {
          print("Tapped");
        },
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: 'MATH 2418'),
            SizedBox(
              height: 6,
            ),
            CustomText(text: 'SCI 2.420'),
            SizedBox(
              height: 6,
            ),
            CustomText(text: '218'),
          ],
        )),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
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
