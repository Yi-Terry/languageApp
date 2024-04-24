import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:language_app/profile_screen/info_box.dart';

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
                              //goToHome();
                              Navigator.pop(context); // Return to whatever screen was before this profile page @Avinash K
                            },
                            icon: const Icon(Icons.arrow_back),   // Back icon instead of profile icon
                            iconSize: 40,
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
}

    return Scaffold(
      body: ListView(
        children: const [
          SizedBox(height: 40),
          Icon(
            Icons.person,
            size: 60,
          ),
          Text(
            "user@email.example",
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(left: 35),
            child: Text(
              "Account Details:",
            ),
          ),
          InfoBox(
            content: "user1234",
            sectionTitle: "Username: ",
            isPswd: false,
          ),
          InfoBox(
              content: "password123!", sectionTitle: "Password: ", isPswd: true)
        ],
      ),
    );
  }
}

}

}


// child: SafeArea(
        //   child: Scaffold(
        //     body: activeScreen ??
        //         Column(
        //           children: [
        //             Container(
        //                 color: Colors.grey,
        //                 padding: const EdgeInsets.symmetric(horizontal: 5.0),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     const Padding(
        //                       padding: EdgeInsets.only(right: 55.0),
        //                       child: Text(
        //                         'Profile',
        //                         style: TextStyle(
        //                             fontSize: 30, fontWeight: FontWeight.bold),
        //                         textAlign: TextAlign.center,
        //                       ),
        //                     ),
        //                     IconButton(
        //                       onPressed: () {
        //                         //routes to profile on press @Marcus F
        //                         goToHome();
        //                       },
        //                       icon: const Icon(Icons.account_circle),
        //                       alignment: Alignment.topLeft,
        //                     )
        //                   ],
        //                 ))
        //           ],
        //         ),
        //   ),

