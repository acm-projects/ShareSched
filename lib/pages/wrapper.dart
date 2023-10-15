import 'package:flutter/material.dart';
import 'package:myapp/pages/login.dart';
//import 'package:myapp/pages/login.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return  const LoginScreen();
  }
}