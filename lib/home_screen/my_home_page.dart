import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_app/home_screen/app_colors.dart' as AppColors;
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: const SafeArea( //added const to remove blue squiggles
        child: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(AssetImage('assets/images/points.png'), size: 50, color: Colors.blue,), 
                      Text('4,835', style: TextStyle(fontSize: 24) ),
                    ],
                  ),
                  Text('Spanish', style: TextStyle(fontSize: 30), ),
                  Row(
                    children: [
                      Icon(Icons.account_circle, size: 40,),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
