import 'package:flutter/material.dart';
import 'package:language_app/app.dart';
import 'package:language_app/home_screen/my_home_page.dart';
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
  List<String> selectedAnswer = [];
  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = StartScreen(switchScreen); //starts at the home screen and uses switch screen function when start button hit
    super.initState();
  }

  void switchScreen(){
    setState(() {
      // activeScreen = LoginScreen();
      activeScreen = const MyHomePage();
    });
  }



@override
Widget build(context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors:
          //   [
          //     Color.fromARGB(255, 248, 22, 22),
          //     Color.fromARGB(255, 255, 216, 100),
          //     Color.fromARGB(255, 248, 22, 22),
          //   ],
          //   begin: startAlignment,
          //   end: endAlignment, 
          //   )
          color: Color.fromARGB(255, 169, 241, 255)
        ),
        child: activeScreen,
      ),
    ),

  );
}
}

