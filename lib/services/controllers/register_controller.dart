import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myapp/models/class_model.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/pages/home.dart';
import 'package:myapp/repositories/class_repository.dart';
import 'package:myapp/repositories/user_respository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  //TextField Controllers

  final userRepo = Get.put(UserRepository());
  final classRepo = Get.put(ClassRepository());
  //final scheduleRepo = Get.put();

  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
  }

  Future<void> createClass(ClassModel classM) async {
    await classRepo.createClass(classM);
  }
}