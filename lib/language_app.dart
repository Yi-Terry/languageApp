import 'package:flutter/material.dart';
import 'package:language_app/app.dart';
import 'package:language_app/start_screen.dart';


class LanguageApp extends StatefulWidget{
  const LanguageApp({super.key});

@override
  State<LanguageApp> createState(){
    return _LanguageAppState();
  }
}

class _LanguageAppState extends State<LanguageApp>
{

  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen); //starts at the home screen and uses switch screen function when start button hit
    super.initState();
  }

  void switchScreen(){
    setState(() {
      // activeScreen = LoginScreen();
    });
  }



@override
Widget build(context){
  return MaterialApp(
    home: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors:
            [
              Color.fromARGB(255, 4, 73, 249),
              Color.fromARGB(255, 3, 52, 143),
            ],
            begin: startAlignment,
            end: endAlignment, 
            )
        ),
        child: activeScreen,
      ),
    ),

  );
}
}

