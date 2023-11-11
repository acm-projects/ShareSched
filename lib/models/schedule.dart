import 'course.dart';

class Schedule {
  final String id;
  List<Course> courses;

  Schedule({required this.id, required this.courses});
  Schedule copyWith({String? id, List<Course>? courses}) {
    return Schedule(
      id: id ?? this.id,
      courses: courses ?? this.courses,
    );
  }
}
