import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  Widget? activeScreen;

  void switchScreen() {
    setState(() {
      activeScreen = const ProfilePage();
    });
  }

  void goToHome() {
    setState(() {
      //goes to profile page
      activeScreen = const MyHomePage();
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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 55.0),
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              //routes to profile on press @Marcus F
                              goToHome();
                            },
                            icon: const Icon(Icons.account_circle),
                            alignment: Alignment.topLeft,
                          )
                        ],
                      ))
                ],
              ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> 97d0bfefd141e86f5c065f8e85f740d4176d4833
