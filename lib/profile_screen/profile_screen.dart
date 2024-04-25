import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:language_app/profile_screen/info_box.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  //Firebase stuff
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    //getting the current user
    return _auth.currentUser;
  }

//retrieve email for current user
  Future<String> fetchUserEmail() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/email')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: email"; //otherwise return error statement
  }

//retrieve current user's full name
  Future<String> fetchUserName() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/fullName')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: fullName"; //otherwise return error
  }

//retrieve current user's password
  Future<String> fetchUserPassword() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/password')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: fullName"; //otherwise return error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
        body: FutureBuilder(
      //widget to get user info
      future:
          // wait for call and run
          Future.wait([fetchUserEmail(), fetchUserName(), fetchUserPassword()]),
      builder: (context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot
          return const Text("Loading...");
        } else if (snapshot.hasError) {
          //error handling
          //print('${snapshot.error}'); ---debug
          return Text(
            'Error: ${snapshot.error}',
          );
        } else {
          //return value for respective function call
          final List<String> data = snapshot.data ?? ['', '', ''];
          final String userEmail = data[0];
          final String userName = data[1];
          final String userPassword = data[2];
          return ListView(
            children: [
              const SizedBox(height: 40),
              const Icon(
                Icons.person,
                size: 60,
              ),
              Text(
                userEmail,
                textAlign: TextAlign.center,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35),
                child: Text(
                  "Account Details:",
                ),
              ),
              InfoBox(
                //change because user should be able to change name
                content: userName,
                sectionTitle: "Name: ",
                isPswd: false,
              ),
              InfoBox(
                  //add update password screen and logic
                  content: userPassword,
                  sectionTitle: "Password: ",
                  isPswd: true)
            ],
          );
        }
      },
    ));
  }
}
=======
      body: ListView(
        children: [
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
              content: "password123!", sectionTitle: "Password: ", isPswd: true),
          ElevatedButton(onPressed: () {      // sends the user to the home page @Terry Y
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return const MyHomePage();  
                  }));
                }, child: const Text('Return to home')),
              
        ],
      ),
    );
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
>>>>>>> 9389313053082907285a885ea951d90f9f73cfbe
