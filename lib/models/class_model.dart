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
    this.subjectPrefix,
    this.courseNumber,
    this.catalogYear,
    this.sectionNumber,
    this.start_time,
    this.end_time,
    this.building,
    this.room,
    this.map_uri,
    this.meetingDays,
    this.professor,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      subjectPrefix: json['subjectPrefix'] as String?,
      courseNumber: json['courseNumber'] as String?,
      catalogYear: json['catalogYear'] as String?,
      sectionNumber: json['sectionNumber'] as String?,
      start_time: json['start_time'] as String?,
      end_time: json['end_time'] as String?,
      building: json['building'] as String?,
      room: json['room'] as String?,
      map_uri: json['map_uri'] as String?,
      meetingDays: json['meetingDays'] != null
          ? List<String>.from(json['meetingDays'])
          : null,
      professor: json['professor'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'subjectPrefix': subjectPrefix,
      'courseNumber': courseNumber,
      'catalogYear': catalogYear,
      'sectionNumber': sectionNumber,
      'start_time': start_time,
      'end_time': end_time,
      'building': building,
      'room': room,
      'map_uri': map_uri,
      'meetingDays': meetingDays,
      'professor': professor,
    };
  }
}