class ClassModel {
  final String? subjectPrefix;
  final String? courseNumber;
  final String? catalogYear;
  final String? sectionNumber;
  final String? start_time;
  final String? end_time;
  final String? building;
  final String? room;
  final String? map_uri;
  final List<String>? meetingDays;
  final String? professor;

  const ClassModel({
    required this.subjectPrefix,
    required this.courseNumber,
    required this.catalogYear,
    required this.sectionNumber,
    required this.start_time,
    required this.end_time,
    required this.building,
    required this.room,
    required this.map_uri,
    required this.meetingDays,
    required this.professor,
  });

  toJson() {
    return {
      "Subject Prefix": subjectPrefix,
      "Course Number": courseNumber,
      "Catalog Year": catalogYear,
    };
  }
}
