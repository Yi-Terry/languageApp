import 'package:flutter/material.dart';

import 'package:home_page/my_home_page.dart';

void main() { 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

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
