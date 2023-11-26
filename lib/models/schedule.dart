import 'class_model.dart';

class Schedule {
  final String id;
  List<ClassModel> courses;

  Schedule({required this.id, required this.courses});
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'courses': courses,
      // Add other properties of Schedule if necessary
    };
  }

  Schedule copyWith({String? id, List<ClassModel>? courses}) {
    return Schedule(
      id: id ?? this.id,
      courses: courses ?? this.courses,
    );
  }
}