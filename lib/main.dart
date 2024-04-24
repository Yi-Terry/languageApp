import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:language_app/language_app.dart';
import 'package:language_app/firebase_options.dart';
import 'package:language_app/app.dart';

void main() async {
  //establish connection to our databse in firebase
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(
      const MyApp()
  );
}

