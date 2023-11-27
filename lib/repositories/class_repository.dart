import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myapp/models/class_model.dart';

class ClassRepository extends GetxController {
  static ClassRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createClass(ClassModel classM) async {
    try {
      await _db.collection("Schedules").add(classM.toJson());
    } catch (e) {
      // Handle any errors here, perhaps log them or show a user-friendly message
      print("Error creating class: $e");
    }
  }
}
