import 'dart:convert';
import 'package:myapp/models/course_data.dart';
import 'package:myapp/models/course_model.dart';
import 'package:myapp/models/schedule_model.dart';
import 'package:http/http.dart' as http;

class RemoteService {
  static const String baseUrl = "https://api.utdnebula.com";
  Map<String, String> headers = {
    'x-api-key': 'AIzaSyDOf7VBYQfOt7hJDCtzGTcfSqWjicoXEXg',
    'Accept': 'application/json',
  };

  Future<CourseData?> getCourseData(CourseModel course) async {
    String? sP = course.subjectPrefix;
    String? cN = course.courseNumber;
    String? cY = course.catalogYear;

    String newUrl = "$baseUrl/course?subject_prefix=$sP&course_number=$cN&catalog_year=$cY";
    var client = http.Client();

    var uri = Uri.parse(newUrl);
    var response = await client.get(uri, headers: headers);

    //print(newUrl);
    //print("API Response Status Code: ${response.statusCode}");

    if (response.statusCode == 200) {
      var json = response.body;
      //print(json);
      try {
        CourseData? courseData = courseDataFromJson(json);
        return courseData;
      } catch (e) {
        print("Error parsing CourseData: $e");
        return null;
      }
    } else {
      print("API request failed with status code ${response.statusCode}");
      return null;
    }
  }

  Future<ScheduleModel?> getScheduleModel(CourseData? courseD, CourseModel model) async {
    if (courseD == null || courseD.data == null || courseD.data!.isEmpty) {
      print("CourseData is null or empty.");
      return null;
    }

    String? id = courseD.data?.first.id;
    String? sI = model.sectionNumber;
    String newUrl = "$baseUrl/section?course_reference=$id&section_number=$sI";
    var client = http.Client();

    var uri = Uri.parse(newUrl);
    var response = await client.get(uri, headers: headers);

    if (response.statusCode == 200) {
      var json = response.body;
    //print(json);
      try {
        return scheduleModelFromJson(json);
      } catch (e) {
        print("Error parsing ScheduleModel: $e");
        return null;
      }
    } else {
      print("API request failed with status code ${response.statusCode}");
      return null;
    }
  }
}
