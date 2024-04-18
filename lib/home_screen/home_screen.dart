import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BL Home Page',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.blue, 
      ), 
      home: MyHomePage(),
    );
  }
}