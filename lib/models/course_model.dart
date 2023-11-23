class CourseModel {
  final String? subjectPrefix;
  final String? courseNumber;
  final String? catalogYear;
  final String? sectionNumber;



  const CourseModel({
    required this.subjectPrefix,
    required this.courseNumber,
    required this.catalogYear,
    required this.sectionNumber,
  });

  toJson(){
    return{
      "Subject Prefix": subjectPrefix,
      "Course Number": courseNumber,
      "Catalog Year": catalogYear,
    };
  }
}
