import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:pie_chart/pie_chart.dart';

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

class Course {
  final String subject;
  final String catalogNumber;
  final String section;
  final Map<String, double> grades;
  final List<String> instructors;

  Course(
    this.subject,
    this.catalogNumber,
    this.section,
    this.grades,
    this.instructors,
  );

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      json['Subject'],
      json['CatalogNumber'],
      json['Section'],
      Map<String, double>.from(json['Grades']),
      List<String>.from(json['Instructors']),
    );
  }
  void printCourseInformation() {
    print("Subject: ${subject}");
    print("Catalog number: ${catalogNumber}");
    print("Section: ${section}");
    print("Grades: ${grades}");
    print("Instructors: ${instructors}");
  }

  static Future<Course?> searchCourses(String courseName) async {
    String subject = courseName.split(" ")[0];
    String catalogNumber = courseName.split(" ")[1];
    final List<String> assetPaths = [
      'assets/grades/Summer2023.json',
      // Add more asset paths as needed
    ];

    for (final assetPath in assetPaths) {
      try {
        final jsonString = await rootBundle.loadString(assetPath);
        final data = jsonDecode(jsonString);

        for (final courseData in data) {
          if (courseData['Subject'] == subject &&
              courseData['CatalogNumber'] == catalogNumber) {
            // Access other properties of the found course as needed
            return Course.fromJson(
                courseData); // Return immediately after finding the first match
          }
        }
      } catch (e) {
        print("Error reading or parsing the JSON asset: $e");
      }
    }
    print("No matching course found in any asset.");
  }
}

class _CourseModalState extends State<CourseModal> {
  Course? courseInformation;
  bool showPieChart = false;
  @override
  void initState() {
    super.initState();
    initializeCourseInformation();
  }

  void initializeCourseInformation() async {
    courseInformation = await Course.searchCourses(widget.courseName!);
    if (courseInformation != null) {
      courseInformation!.printCourseInformation();
    }

    setState(() {
      showPieChart = true;
    });
  }

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
                      ),
                      if (courseInformation != null && showPieChart)
                        CustomPieChart(courseInformation: courseInformation),
                    ]))))));
  }
}

class CustomPieChart extends StatelessWidget {
  // The map you provided earlier
  final Course? courseInformation;
  CustomPieChart({required this.courseInformation});
  final Map<String, Color> gradeColors = {
    'A+': const Color(0xFF66BB6A), // A lighter green
    'A': const Color(0xFF4CAF50), // A medium green
    'A-': const Color(0xFF388E3C), // A darker green
    'B+': const Color(0xFFFFEB3B), // A bright yellow
    'B': const Color(0xFFFFC107), // Amber
    'B-': const Color(0xFFFF9800), // Orange
    'C+': const Color(0xFFF57C00), // Deep orange
    'C': const Color(0xFFEF6C00), // A darker shade of orange
    'C-': const Color(0xFFE65100), // Even darker orange
    'D+': const Color(0xFFD32F2F), // Red
    'D': const Color(0xFFC62828), // Dark red
    'F': const Color(0xFFB71C1C), // Darker red
    'W': const Color(0xFF757575), // Grey
    'I': const Color(0xFF616161), // Darker grey
  };

  @override
  Widget build(BuildContext context) {
    // Assuming courseInformation!.grades is something like {'A+': 40, 'A': 25, ...}
    Map<String, double> dataMap = courseInformation!.grades;
    List<Color> colorList =
        dataMap.keys.map((key) => gradeColors[key]!).toList();

    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      centerText: "Grades",
      centerTextStyle: const TextStyle(
        fontFamily: 'Quicksand',
        fontSize: 16,
        color: Colors.black,
      ),
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValuesOutside: true,
        showChartValueBackground: true,
        showChartValues: false,
        chartValueStyle: defaultChartValueStyle.copyWith(
          color: Colors.white,
        ),
      ),
      colorList: colorList,
    );
  }
}
