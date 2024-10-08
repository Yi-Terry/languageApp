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
                _buildPointsWidget(), //display total points
                Padding(padding: EdgeInsets.only(bottom: 20)),
              ],
            ),
            Center(
              child:
                  _buildQuestionsCompletedWidget(), //display questions completed
            ),
            Center(
              child:
                  _buildQuestionsCorrectWidget(), //display # of correct questions
            ),
            Center(
              child: _buildQuestionsWrongWidget(), //disply # of wrong questions
            ),
            Center(
              child:
                  _buildQuestionsCorrectPercentageWidget(), //display percentage of correct questions
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
    //widget to get user name
    return FutureBuilder<String>(
      future: fetchUserName(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final String userName =
              snapshot.data ?? ""; //getting snapshot of user data
          return Text(
            "Progress of " + userName,
            style: const TextStyle(fontSize: 20), //displaying it
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
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int userPoints =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            '$userPoints', style: const TextStyle(fontSize: 20), //displaying it
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
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int questionsCompleted =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            "Total Questions Completed: $questionsCompleted",
            style: const TextStyle(fontSize: 20), //displaying it
          );
        }
      },
    );
  }

  Widget _buildQuestionsCorrectWidget() {
    //widget to get total # of questions correct
    return FutureBuilder<int>(
      future: fectchCorrectQuestions(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int questionsCorrect =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            "Total Questions Completed Correctly : $questionsCorrect",
            style: const TextStyle(
                fontSize: 20, color: Colors.green), //displaying it
          );
        }
      },
    );
  }

  Widget _buildQuestionsWrongWidget() {
    //widget to get total # of questions wrong
    return FutureBuilder<int>(
      future: fetchQuestionsWrong(), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final int questionsWrong =
              snapshot.data ?? 0; //getting snapshot of user data
          return Text(
            "Total Questions Completed Incorrectly : $questionsWrong",
            style: const TextStyle(
                fontSize: 20, color: Colors.red), //displaying it
          );
        }
      },
    );
  }

  Widget _buildQuestionsCorrectPercentageWidget() {
    //widget to get percentage of questions correct
    return FutureBuilder<List<int>>(
      future: Future.wait([
        fetchQuestionsWrong(),
        fectchCorrectQuestions()
      ]), //runs this program
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //loading snapshot of data
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          //error handling
          return Text('Error: ${snapshot.error}');
        } else {
          final List<int> data = snapshot.data ?? [0, 0];
          final int correctCount = data[1];
          final int wrongCount = data[0];
          final int totalQuestions = correctCount + wrongCount;
          final double correctPercentage =
              (correctCount / totalQuestions) * 100;
          if (correctPercentage > 65.0) {
            return Column(
              //return congradulation if correct % > 65
              children: [
                Text(
                  "You answered " +
                      correctPercentage.toStringAsFixed(2) +
                      "% of questions correctly!",
                  style: const TextStyle(
                      fontSize: 20, color: Colors.green), //displaying it
                ),
                Text(
                  "Great Job! Keep up the good work!",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            );
          } else {
            return Column(
              //return lower level suggestion if correct % < 65
              children: [
                Text(
                  "You answered " +
                      correctPercentage.toStringAsFixed(2) +
                      "% of questions correctly.",
                  style: const TextStyle(
                      fontSize: 20, color: Colors.red), //displaying it
                ),
                Text(
                  "Consider trying a lower difficulty level!",
                  style: TextStyle(fontSize: 16),
                )
              ],
            );
          }
        }
      },
    );
  }
}
