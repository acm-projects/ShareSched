import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/models/class_model.dart';

class ClassRepository extends GetxController {
  static ClassRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createClass(ClassModel classM) async {
    await _db.collection("Schedules").add(classM.toJson());
  }
}
