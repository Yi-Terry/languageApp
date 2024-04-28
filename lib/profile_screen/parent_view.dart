import 'package:flutter/material.dart';
import 'package:language_app/profile_screen/profile_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ParentViewPage extends StatefulWidget {
  const ParentViewPage({super.key});

  @override
  State<ParentViewPage> createState() {
    return ParentViewPageState();
  }
}

class ParentViewPageState extends State<ParentViewPage> {
//Firebase connection
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    //getting the current user
    return _auth.currentUser;
  }

  Future<int> fetchUserPoints() async {
    //getting user ponts
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/points')
          .once(); //going to the table to get this
      final DataSnapshot snapshot =
          event.snapshot; //handling the data into a snapshot
      if (snapshot.value != null) {
        return snapshot.value as int; //returning the value as an int
      }
    }
    return 0; //otherwise return 0
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

  Future<int> fectchCorrectQuestions() async {
    //getting user # of correct qusestions @Marcus F
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/statistics/questionsCorrect')
          .once(); //going to the table to get this
      final DataSnapshot snapshot =
          event.snapshot; //handling the data into a snapshot
      if (snapshot.value != null) {
        return snapshot.value as int; //returning the value as an int
      }
    }
    return 0; //otherwise return 0
  }

  Future<int> fetchQuestionsCompleted() async {
    //getting user # of completed qusestions @Marcus F
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/statistics/questionsCompleted')
          .once(); //going to the table to get this
      final DataSnapshot snapshot =
          event.snapshot; //handling the data into a snapshot
      if (snapshot.value != null) {
        return snapshot.value as int; //returning the value as an int
      }
    }
    return 0; //otherwise return 0
  }

  Future<int> fetchQuestionsWrong() async {
    //getting user # of completed qusestions @Marcus F
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/statistics/questionsWrong')
          .once(); //going to the table to get this
      final DataSnapshot snapshot =
          event.snapshot; //handling the data into a snapshot
      if (snapshot.value != null) {
        return snapshot.value as int; //returning the value as an int
      }
    }
    return 0; //otherwise return 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: _buildUserNameWidget(),
          backgroundColor: Colors.grey.shade400,
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          children: [
            //RETURN USER STATISTICS
            /*
            Total:
            - total points
            For current session:
            - # of points earned this session
            - correct answer
            - number of questions answered
            - number of questions answered for each difficulty level
            */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total Points: ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                ImageIcon(
                  AssetImage('assets/images/points.png'),
                  size: 30,
                  color: Colors.blue,
                ),
                _buildPointsWidget(),
                Padding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
            Center(
              child: _buildQuestionsCompletedWidget(),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to profile page
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ProfilePage();
                }));
              },
              child: const Text('Return to Profile'),
            ),
          ],
        ));
  }

  Widget _buildUserNameWidget() {
    //widget to get points
    return FutureBuilder<String>(
      future: fetchUserName(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of dat
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final String userName =
              snapshot.data ?? ""; //getting snapshot of user data
          return Text(
            "Progress of " + userName,
            style: const TextStyle(fontSize: 24), //displaying it
          );
        }
      },
    );
  }

  Widget _buildPointsWidget() {
    //widget to get points
    return FutureBuilder<int>(
      future: fetchUserPoints(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of dat
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int userPoints =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            '$userPoints', style: const TextStyle(fontSize: 24), //displaying it
          );
        }
      },
    );
  }

  Widget _buildQuestionsCompletedWidget() {
    //widget to get questions completed
    return FutureBuilder<int>(
      future: fetchQuestionsCompleted(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of dat
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int questionsCompleted =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            "Total Questions Completed: $questionsCompleted",
            style: const TextStyle(fontSize: 24), //displaying it
          );
        }
      },
    );
  }
}
