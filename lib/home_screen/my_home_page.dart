import 'package:flutter/material.dart';
import 'package:language_app/home_screen/color_button.dart';
import 'package:language_app/home_screen/app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState(){
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage>{
  List<String> selectedAnswer = [];
  Widget? activeScreen;

  void chooseAnswer(String answer){
    selectedAnswer.add(answer);
  }
  void goToEasy(){
    //activeScreen = EasyLevel(onSelectAnswer: chooseAnswer);
  }
  void goToMedium(){
    //activeScreen = MediumLevel(onSelectAnswer: chooseAnswer);
  }
  void goToHard(){
    //activeScreen = HardLevel(onSelectAnswer: chooseAnswer);
  }
  void goToPremium(){
    //activeScreen = PremiumLevel(onSelectAnswer: chooseAnswer);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //color: AppColors.background,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10,right: 10), //put into container so margin can be applied to container
                child: const Row( //row for points, language name, profile
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ImageIcon(
                        AssetImage('assets/images/points.png'),
                        size: 50,
                        color: Colors.blue,
                      ),
                      Text('4,835', style: TextStyle(fontSize: 24)),
                    ],
                  ),

                  //Language you are working title
                  Padding(
                    padding: EdgeInsets.only(right: 55.0), //shift spanish to left by padding to the right
                      child: Text(
                        'Spanish',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                  ),
                        ),
                  Row(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 40,
                      ),
                    ],
                  )
                ],
              ),
              ),
              const SizedBox(height: 10), //puts space between top and the first row
              

              const Spacer(),

              Row( //Level 1
                  children: [

                    const Spacer(),

                    ColoredButton(
                      color: Colors.green, 
                      text: "Easy",
                      onTap: (){ goToEasy();
                      }),

                    const Spacer()

                  ]),

                  const Spacer(),

                  Row( //Level 2 & 3
              children: [
                
                    const Spacer(),
                    
                    ColoredButton(
                      color: Colors.yellow, 
                      text: "Medium",
                      onTap: (){ goToMedium();
                      }),

                    const Spacer(), const Spacer(),

                    ColoredButton(
                      color: Colors.red, 
                      text: "Hard",
                      onTap: (){ goToHard();
                      }),
                      const Spacer(),
                  ]),

                  const Spacer(),

              Row( //Level 4
                children: [

                    const Spacer(),
                    
                    ColoredButton(
                      color: const Color.fromARGB(255, 255, 215, 0), 
                      text: "Premium",
                      onTap: (){ goToPremium();
                      }),
                    const Spacer()
                  ]),
                  
                  const Spacer(),
            ],
          ),
        ),
      ),
    );
  }  
}