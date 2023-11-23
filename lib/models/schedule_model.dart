// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
    int? status;
    String? message;
    List<Datum>? data;

    ScheduleModel({
        this.status,
        this.message,
        this.data,
    });

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    AcademicSession? academicSession;
    dynamic attributes;
    dynamic coreFlags;
    String? courseReference;
    dynamic gradeDistribution;
    String? instructionMode;
    String? internalClassNumber;
    List<Meeting>? meetings;
    List<String>? professors;
    dynamic sectionCorequisites;
    String? sectionNumber;
    String? syllabusUri;
    List<dynamic>? teachingAssistants;

    Datum({
        this.id,
        this.academicSession,
        this.attributes,
        this.coreFlags,
        this.courseReference,
        this.gradeDistribution,
        this.instructionMode,
        this.internalClassNumber,
        this.meetings,
        this.professors,
        this.sectionCorequisites,
        this.sectionNumber,
        this.syllabusUri,
        this.teachingAssistants,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        academicSession: json["academic_session"] == null ? null : AcademicSession.fromJson(json["academic_session"]),
        attributes: json["attributes"],
        coreFlags: json["core_flags"],
        courseReference: json["course_reference"],
        gradeDistribution: json["grade_distribution"],
        instructionMode: json["instruction_mode"],
        internalClassNumber: json["internal_class_number"],
        meetings: json["meetings"] == null ? [] : List<Meeting>.from(json["meetings"]!.map((x) => Meeting.fromJson(x))),
        professors: json["professors"] == null ? [] : List<String>.from(json["professors"]!.map((x) => x)),
        sectionCorequisites: json["section_corequisites"],
        sectionNumber: json["section_number"],
        syllabusUri: json["syllabus_uri"],
        teachingAssistants: json["teaching_assistants"] == null ? [] : List<dynamic>.from(json["teaching_assistants"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "academic_session": academicSession?.toJson(),
        "attributes": attributes,
        "core_flags": coreFlags,
        "course_reference": courseReference,
        "grade_distribution": gradeDistribution,
        "instruction_mode": instructionMode,
        "internal_class_number": internalClassNumber,
        "meetings": meetings == null ? [] : List<dynamic>.from(meetings!.map((x) => x.toJson())),
        "professors": professors == null ? [] : List<dynamic>.from(professors!.map((x) => x)),
        "section_corequisites": sectionCorequisites,
        "section_number": sectionNumber,
        "syllabus_uri": syllabusUri,
        "teaching_assistants": teachingAssistants == null ? [] : List<dynamic>.from(teachingAssistants!.map((x) => x)),
    };
}

class AcademicSession {
    DateTime? endDate;
    String? name;
    DateTime? startDate;

    AcademicSession({
        this.endDate,
        this.name,
        this.startDate,
    });

    factory AcademicSession.fromJson(Map<String, dynamic> json) => AcademicSession(
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        name: json["name"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    );

    Map<String, dynamic> toJson() => {
        "end_date": endDate?.toIso8601String(),
        "name": name,
        "start_date": startDate?.toIso8601String(),
    };
}

class Meeting {
    DateTime? endDate;
    DateTime? endTime;
    Location? location;
    List<String>? meetingDays;
    String? modality;
    DateTime? startDate;
    DateTime? startTime;

    Meeting({
        this.endDate,
        this.endTime,
        this.location,
        this.meetingDays,
        this.modality,
        this.startDate,
        this.startTime,
    });

    factory Meeting.fromJson(Map<String, dynamic> json) => Meeting(
        endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        meetingDays: json["meeting_days"] == null ? [] : List<String>.from(json["meeting_days"]!.map((x) => x)),
        modality: json["modality"],
        startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
    );

    Map<String, dynamic> toJson() => {
        "end_date": endDate?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "location": location?.toJson(),
        "meeting_days": meetingDays == null ? [] : List<dynamic>.from(meetingDays!.map((x) => x)),
        "modality": modality,
        "start_date": startDate?.toIso8601String(),
        "start_time": startTime?.toIso8601String(),
    };
}

class Location {
    String? building;
    String? mapUri;
    String? room;

    Location({
        this.building,
        this.mapUri,
        this.room,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        building: json["building"],
        mapUri: json["map_uri"],
        room: json["room"],
    );

    Map<String, dynamic> toJson() => {
        "building": building,
        "map_uri": mapUri,
        "room": room,
    };
}
