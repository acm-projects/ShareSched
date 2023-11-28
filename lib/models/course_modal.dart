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
  final String term;

  Course(
    this.subject,
    this.catalogNumber,
    this.section,
    this.grades,
    this.instructors,
    this.term,
  );

  factory Course.fromJson(Map<String, dynamic> json, String year) {
    return Course(
        json['Subject'],
        json['CatalogNumber'],
        json['Section'],
        Map<String, double>.from(json['Grades']),
        List<String>.from(json['Instructors']),
        year);
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
      'assets/grades/Fall_2022.json',
      'assets/grades/Spring_2023.json',
      'assets/grades/Summer_2023.json',
      'assets/grades/Summer_2022.json',
      'assets/grades/Spring_2022.json',
      'assets/grades/Summer_2021.json',
      'assets/grades/Spring_2021.json',
    ];

    for (final assetPath in assetPaths) {
      try {
        final jsonString = await rootBundle.loadString(assetPath);
        final data = jsonDecode(jsonString);
        final List<String> pathParts = assetPath.split('/')[2].split('_');
        final season = pathParts[0];
        final year = pathParts[1].split('.')[0];

        for (final courseData in data) {
          if (courseData['Subject'] == subject &&
              courseData['CatalogNumber'] == catalogNumber) {
            return Course.fromJson(
              courseData,
              '$season $year',
            );
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
                          Expanded(
                            // Wrap the FittedBox in an Expanded widget
                            child: FittedBox(
                              child: Text('Course Name: ${widget.courseName}'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.person),
                          const SizedBox(width: 10),
                          Expanded(
                            // Wrap the FittedBox in an Expanded widget
                            child: FittedBox(
                              child: Text('Professor: ${widget.professorName}'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          const Icon(Icons.star),
                          const SizedBox(width: 10),
                          Expanded(
                            // Wrap the FittedBox in an Expanded widget
                            child: FittedBox(
                              child: Text(
                                  'Professor Rating: ${widget.professorRating}'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      if (courseInformation != null && showPieChart)
                        Column(
                          children: [
                            Text(
                              '${courseInformation!.term}', // Display the professor's name
                              style: TextStyle(
                                fontFamily: 'Quicksand-SemiBold',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            CustomPieChart(
                                courseInformation: courseInformation),
                          ],
                        )
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
        showChartValues: true,
        showChartValuesInPercentage: true,
        decimalPlaces: 0,
        chartValueStyle: defaultChartValueStyle.copyWith(
          fontFamily: 'Quicksand-SemiBold',
          letterSpacing: 1.3,
          color: Colors.black,
        ),
      ),
      colorList: colorList,
    );
  }
}
