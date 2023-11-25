import 'package:flutter/material.dart';
import 'package:myapp/colors/app_colors.dart';

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
