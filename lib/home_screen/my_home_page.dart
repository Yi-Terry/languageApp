import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:language_app/home_screen/color_button.dart';
import 'package:language_app/levels/easy_level.dart';
import 'package:language_app/levels/medium_level.dart';
import 'package:language_app/levels/hard_level.dart';
import 'package:language_app/profile_screen/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> selectedAnswer = [];
  Widget? activeScreen;

  void chooseAnswer(String answer) {
    selectedAnswer.add(answer);
  }

  void switchScreen() {
    setState(() {
      // activeScreen = LoginScreen();
      activeScreen = const MyHomePage();
    });
  }

  void goToEasy() {
    //goes to the easy questions when called
    // print("easy function called");  - debug statement
    setState(() {
      // print("set state"); - debug statement
      activeScreen = EasyLevel(onSelectAnswer: chooseAnswer);
    });
    //switchScreen();
  }

  void goToMedium() {
    //goes to medium questions
    setState(() {
      activeScreen = MediumLevel(onSelectAnswer: chooseAnswer);
    });
  }

  void goToHard() {
    //goes to hard questions
    setState(() {
      activeScreen = HardLevel(onSelectAnswer: chooseAnswer);
    });
  }

  void goToPremium() {
    //activeScreen = PremiumLevel(onSelectAnswer: chooseAnswer);
  }

  void goToProfile() {
    setState(() {
      //goes to profile page
      activeScreen = const ProfilePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          body: activeScreen ??
              Column(
                children: [
                  Container(
                    color: Colors.grey,
                    child: Row(
                      //row for points, language name, profile @Chris Z
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            ImageIcon(
                              AssetImage('assets/images/points.png'),
                              size: 50,
                              color: Colors.blue,
                            ),
                            Text('4,835', style: TextStyle(fontSize: 24)),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              right:
                                  55.0), //shift spanish to left by padding to the right @Chris Z
                          child: Text(
                            'Spanish',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //routes to profile on press @Marcus F
                                goToProfile();
                              },
                              icon: const Icon(Icons.account_circle),
                            ),
                            const SizedBox(
                              width: 5,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                      height:
                          10), //puts space between top and the first row @Chris Z

                  const Spacer(),

                  Row(//Level 1
                      children: [
                    const Spacer(), //TO THE LEFT OF GREEN @Chris Z

                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 5)),
                      child: ColoredButton(
                          color: Colors.green,
                          text: "Easy",
                          onTap: () {
                            goToEasy();
                          }),
                    ),

                    const Spacer() //TO THE RIGHT OF GREEN @Chris Z
                  ]),

                  const Spacer(), //BETWEEN 1ST AND 2ND ROW @Chris Z

                  Row(//Level 2 & 3
                      children: [
                    const Spacer(), //TO THE LEFT OF YELLOW @Chris Z

                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 5)),
                      child: ColoredButton(
                          color: Colors.yellow,
                          text: "Medium",
                          onTap: () {
                            goToMedium();
                          }),
                    ),

                    const Spacer(),
                    const Spacer(), //BETWEEN YELLOW AND RED @Chris Z

                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 5)),
                      child: ColoredButton(
                          color: Colors.red,
                          text: "Hard",
                          onTap: () {
                            goToHard();
                          }),
                    ),

                    const Spacer(), //TO THE RIGHT OF RED @Chris Z
                  ]),

                  const Spacer(), //BETWEEN 2ND AND 3RD ROW @Chris Z

                  Row(//Level 4
                      children: [
                    const Spacer(), //TO THE LEFT OF GOLD @Chris Z

                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 5)),
                      child: ColoredButton(
                          color: const Color.fromARGB(255, 255, 215, 0),
                          text: "Premium",
                          onTap: () {
                            goToPremium();
                          }),
                    ),

                    const Spacer() //TO THE RIGHT OF GOLD @Chris Z
                  ]),

                  const Spacer(), //UNDER GOLD @Chris Z
                ],
              ),
        ),
      ),
    );
  }
}
