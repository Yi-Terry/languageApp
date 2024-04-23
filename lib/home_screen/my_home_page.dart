import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:language_app/home_screen/color_button.dart';
import 'package:language_app/login_screen.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/collect_rewards.dart';
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

  // choose answer methods for each type of questions --> will bring them to results page @Kelly O
  void chooseAnswerEasy(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == easyQuestions.length) {
      setState(() {
        activeScreen = CollectRewardsPage(
            questions: easyQuestions, chosenAnswers: selectedAnswer);
      });
    }
  }

  void chooseAnswerMedium(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == mediumQuestions.length) {
      setState(() {
        activeScreen = CollectRewardsPage(
            questions: mediumQuestions, chosenAnswers: selectedAnswer);
      });
    }
  }

  void chooseAnswerHard(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == hardQuestions.length) {
      setState(() {
        activeScreen = CollectRewardsPage(
            questions: hardQuestions, chosenAnswers: selectedAnswer);
      });
    }
  }

  void chooseAnswerPrem(String answer) {
    selectedAnswer.add(answer);
    if (selectedAnswer.length == premiumQuestions.length) {
      setState(() {
        //activeScreen = CollectRewardsPage(questions: premiumQuestions, chosenAnswers: selectedAnswer);
      });
    }
  }

  void switchScreen() {
    setState(() {
      // activeScreen = LoginScreen();
      activeScreen = const MyHomePage();
    });
  }

  void goToEasy() {
    //goes to the easy questions when called @Kelly O
    // print("easy function called");  - debug statement
    setState(() {
      // print("set state"); - debug statement
      activeScreen = EasyLevel(onSelectAnswer: chooseAnswerEasy);
    });
    //switchScreen();
  }

  void goToMedium() {
    //goes to medium questions @Kelly O
    setState(() {
      activeScreen = MediumLevel(onSelectAnswer: chooseAnswerMedium);
    });
  }

  void goToHard() {
    //goes to hard questions @Kelly O
    setState(() {
      activeScreen = HardLevel(onSelectAnswer: chooseAnswerHard);
    });
  }

  void goToPremium() {
    //goes to premium question when unlocked @Kelly O
    //activeScreen = PremiumLevel(onSelectAnswer: chooseAnswerPremium);
  }

  void goToProfile() {
    setState(() {
      // if (activeScreen is MyHomePage) {
      //   print("swiching to protile");
      activeScreen = const ProfilePage();
      //   print("switched to protile");
      // } else if (activeScreen is ProfilePage) {
      //   activeScreen = const MyHomePage();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 5),
                    ImageIcon(
                      AssetImage('assets/images/points.png'),
                      size: 50,
                      color: Colors.blue,
                    ),
                    Text(
                      '4,835',
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
                const Text(
                  'Spanish',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    //routes to profile on press @Marcus F
                    goToProfile();
                  },
                  icon: const Icon(Icons.account_circle),
                ),
              ],
            ),
          ),
          body: activeScreen ??
              Column(
                children: [
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

                  const Row(
                    children: [
                      Spacer(),
                      ImageIcon(
                        AssetImage('assets/images/premium_crown.png'),
                        size: 50,
                        color: Colors.orange,
                      ),
                      Spacer(),
                    ],
                  ),

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

                  // place holder for logout function
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                title: Text('Confirmation !!!'),
                                content: Text('Are you sure to Log Out ? '),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();

                                      FirebaseAuth.instance.signOut();

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (context) {
                                        return LoginScreen();
                                      }));
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.logout)),
                ],
              ),
        ),
      ),
    );
  }
}
