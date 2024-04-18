import 'package:flutter/material.dart';

const startAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class StartScreen extends StatelessWidget {
  const StartScreen(this.startLearning,{super.key});

  final void Function() startLearning;
  
  @override
  Widget build(context) {
    return  Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            'assets/images/app_icon.jpeg',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          const SizedBox(
            height: 80,
          ),
          const Text("Learn a new Language!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              )),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            icon:const Icon(Icons.arrow_right_alt),
            onPressed: startLearning,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            label: const Text("Start Learning"),
          ),
        ]),
      );
  }
}