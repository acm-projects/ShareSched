import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/welcome.dart';

import 'package:myapp/firebase_options.dart';
import 'package:myapp/pages/custom_widgets.dart';
import 'package:myapp/pages/wrapper.dart';
import 'pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.settings( // Initialize Firestore
  //   persistenceEnabled: true, // Enable local persistence
  // );

   // Initialize Firestore with settings
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(
    persistenceEnabled: true, // Enable local persistence
    // Add more settings as needed
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
