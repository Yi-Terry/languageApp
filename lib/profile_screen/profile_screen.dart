import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:language_app/profile_screen/info_box.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:language_app/profile_screen/parent_view_login_screen.dart';

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

  //Firebase connection
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
                  isPswd: true),
              Padding(
                padding: EdgeInsets.only(bottom: 30),
              ),
              ElevatedButton(
                  onPressed: () {
                    // sends the user to the parent view page @Marcus F
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ParentViewLogin();
                    }));
                  },
                  child: const Text('Sign in to parent view')),
              ElevatedButton(
                  onPressed: () {
                    // sends the user to the home page @Terry Y
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const MyHomePage();
                    }));
                  },
                  child: const Text('Return to home')),
            ],
          );
        }
      },
    ));
  }
}
