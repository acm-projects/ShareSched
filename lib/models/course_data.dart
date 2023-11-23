// To parse this JSON data, do
//
//     final courseData = courseDataFromJson(jsonString);

import 'dart:convert';

CourseData courseDataFromJson(String str) => CourseData.fromJson(json.decode(str));

String courseDataToJson(CourseData data) => json.encode(data.toJson());

class CourseData {
    int? status;
    String? message;
    List<Datum>? data;

    CourseData({
        this.status,
        this.message,
        this.data,
    });

    factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
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
    /*
    String? activityType;
    dynamic attributes;
    String? catalogYear;
    String? classLevel;
    Requisites? coOrPreRequisites;
    Requisites? corequisites;
    */
    String? courseNumber;
    String? creditHours;
    /*
    String? description;
    String? enrollmentReqs;
    String? grading;
    String? internalCourseNumber;
    String? laboratoryContactHours;
    String? lectureContactHours;
    String? offeringFrequency;
    Prerequisites? prerequisites;
    String? school;
    List<String>? sections;
    String? subjectPrefix;
    String? title;
    */

    Datum({
        required this.id,
        /*
        this.activityType,
        this.attributes,
        this.catalogYear,
        this.classLevel,
        this.coOrPreRequisites,
        this.corequisites,
        */
        this.courseNumber,
        this.creditHours,
        /*
        this.description,
        this.enrollmentReqs,
        this.grading,
        this.internalCourseNumber,
        this.laboratoryContactHours,
        this.lectureContactHours,
        this.offeringFrequency,
        this.prerequisites,
        this.school,
        this.sections,
        this.subjectPrefix,
        this.title,
        */
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        /*
        activityType: json["activity_type"],
        attributes: json["attributes"],
        catalogYear: json["catalog_year"],
        classLevel: json["class_level"],
        coOrPreRequisites: json["co_or_pre_requisites"] == null ? null : Requisites.fromJson(json["co_or_pre_requisites"]),
        corequisites: json["corequisites"] == null ? null : Requisites.fromJson(json["corequisites"]),
        */
        courseNumber: json["course_number"],
        creditHours: json["credit_hours"],
        /*
        description: json["description"],
        enrollmentReqs: json["enrollment_reqs"],
        grading: json["grading"],
        internalCourseNumber: json["internal_course_number"],
        laboratoryContactHours: json["laboratory_contact_hours"],
        lectureContactHours: json["lecture_contact_hours"],
        offeringFrequency: json["offering_frequency"],
        prerequisites: json["prerequisites"] == null ? null : Prerequisites.fromJson(json["prerequisites"]),
        school: json["school"],
        sections: json["sections"] == null ? [] : List<String>.from(json["sections"]!.map((x) => x)),
        subjectPrefix: json["subject_prefix"],
        title: json["title"],
        */
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        /*
        "activity_type": activityType,
        "attributes": attributes,
        "catalog_year": catalogYear,
        "class_level": classLevel,
        "co_or_pre_requisites": coOrPreRequisites?.toJson(),
        "corequisites": corequisites?.toJson(),
        */
        "course_number": courseNumber,
        "credit_hours": creditHours,
        /*
        "description": description,
        "enrollment_reqs": enrollmentReqs,
        "grading": grading,
        "internal_course_number": internalCourseNumber,
        "laboratory_contact_hours": laboratoryContactHours,
        "lecture_contact_hours": lectureContactHours,
        "offering_frequency": offeringFrequency,
        "prerequisites": prerequisites?.toJson(),
        "school": school,
        "sections": sections == null ? [] : List<dynamic>.from(sections!.map((x) => x)),
        "subject_prefix": subjectPrefix,
        "title": title,
        */
    };
}


/*
class Requisites {
    String? name;
    List<CoOrPreRequisitesOption>? options;
    int? required;
    String? type;

    Requisites({
        this.name,
        this.options,
        this.required,
        this.type,
    });

    factory Requisites.fromJson(Map<String, dynamic> json) => Requisites(
      //TODO parsing error occurs here
        name: json["name"],
        options: json["options"] == null ? [] : List<CoOrPreRequisitesOption>.from(json["options"]!.map((x) => CoOrPreRequisitesOption.fromJson(x))),
        required: json["required"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
        "type": type,
    };
}

class CoOrPreRequisitesOption {
    String? name;
    List<FluffyOption>? options;
    int? required;
    String? type;
    Choices? choices;

    CoOrPreRequisitesOption({
        this.name,
        this.options,
        this.required,
        this.type,
        this.choices,
    });

    factory CoOrPreRequisitesOption.fromJson(Map<String, dynamic> json) => CoOrPreRequisitesOption(
        name: json["name"],
        options: json["options"] == null ? [] : List<FluffyOption>.from(json["options"]!.map((x) => FluffyOption.fromJson(x))),
        required: json["required"],
        type: json["type"],
        choices: json["choices"] == null ? null : Choices.fromJson(json["choices"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
        "type": type,
        "choices": choices?.toJson(),
    };
}

class Choices {
    String? name;
    List<ChoicesOption>? options;
    int? required;
    String? type;

    Choices({
        this.name,
        this.options,
        this.required,
        this.type,
    });

    factory Choices.fromJson(Map<String, dynamic> json) => Choices(
        name: json["name"],
        options: json["options"] == null ? [] : List<ChoicesOption>.from(json["options"]!.map((x) => ChoicesOption.fromJson(x))),
        required: json["required"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
        "type": type,
    };
}

class ChoicesOption {
    String? classReference;
    MinimumGrade? minimumGrade;
    String? type;
    String? name;
    List<PurpleOption>? options;
    int? required;

    ChoicesOption({
        this.classReference,
        this.minimumGrade,
        this.type,
        this.name,
        this.options,
        this.required,
    });

    factory ChoicesOption.fromJson(Map<String, dynamic> json) => ChoicesOption(
        classReference: json["class_reference"],
        minimumGrade: minimumGradeValues.map[json["minimum_grade"]]!,
        type: json["type"],
        name: json["name"],
        options: json["options"] == null ? [] : List<PurpleOption>.from(json["options"]!.map((x) => PurpleOption.fromJson(x))),
        required: json["required"],
    );

    Map<String, dynamic> toJson() => {
        "class_reference": classReference,
        "minimum_grade": minimumGradeValues.reverse[minimumGrade],
        "type": type,
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
    };
}

enum MinimumGrade {
    F
}

final minimumGradeValues = EnumValues({
    "F": MinimumGrade.F
});

class PurpleOption {
    String? classReference;
    MinimumGrade? minimumGrade;
    Type? type;
    String? major;

    PurpleOption({
        this.classReference,
        this.minimumGrade,
        this.type,
        this.major,
    });

    factory PurpleOption.fromJson(Map<String, dynamic> json) => PurpleOption(
        classReference: json["class_reference"],
        minimumGrade: minimumGradeValues.map[json["minimum_grade"]]!,
        type: typeValues.map[json["type"]]!,
        major: json["major"],
    );

    Map<String, dynamic> toJson() => {
        "class_reference": classReference,
        "minimum_grade": minimumGradeValues.reverse[minimumGrade],
        "type": typeValues.reverse[type],
        "major": major,
    };
}

enum Type {
    COURSE,
    MAJOR
}

final typeValues = EnumValues({
    "course": Type.COURSE,
    "major": Type.MAJOR
});

class FluffyOption {
    String? name;
    List<PurpleOption>? options;
    int? required;
    String? type;

    FluffyOption({
        this.name,
        this.options,
        this.required,
        this.type,
    });

    factory FluffyOption.fromJson(Map<String, dynamic> json) => FluffyOption(
        name: json["name"],
        options: json["options"] == null ? [] : List<PurpleOption>.from(json["options"]!.map((x) => PurpleOption.fromJson(x))),
        required: json["required"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
        "type": type,
    };
}

class Prerequisites {
    String? name;
    List<PrerequisitesOption>? options;
    int? required;
    String? type;

    Prerequisites({
        this.name,
        this.options,
        this.required,
        this.type,
    });

    factory Prerequisites.fromJson(Map<String, dynamic> json) => Prerequisites(
        name: json["name"],
        options: json["options"] == null ? [] : List<PrerequisitesOption>.from(json["options"]!.map((x) => PrerequisitesOption.fromJson(x))),
        required: json["required"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
        "required": required,
        "type": type,
    };
}

class PrerequisitesOption {
    String? condition;
    String? description;
    String? type;

    PrerequisitesOption({
        this.condition,
        this.description,
        this.type,
    });

    factory PrerequisitesOption.fromJson(Map<String, dynamic> json) => PrerequisitesOption(
        condition: json["condition"],
        description: json["description"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "condition": condition,
        "description": description,
        "type": type,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
*/