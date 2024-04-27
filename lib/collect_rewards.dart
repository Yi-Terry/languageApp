import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CollectRewardsPage extends StatelessWidget {
  CollectRewardsPage(
      {super.key,
      required this.questions,
      required this.chosenAnswers,
      required this.collectRewards});

  final List<QuizQuestion>
      questions; // could be easy, medium, hard, premium questions
  final List<String> chosenAnswers;
  final void Function() collectRewards;

  List<Map<String, Object>> getSummaryData() {
    //mapping of information
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < 3; i++) {
      // Changed condition from "chosenAnswers.length" to "3" since every level has 3 questions. @ Avinash K
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }

  void emptyPage() {
    CollectRewardsPage(
      questions: const [],
      chosenAnswers: const [],
      collectRewards: () {},
    );
  }

  // Took Firebase stuff from my_home_page @ Avinash K
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

  // Updates the current user's points in the database. pointsToBeAdded = earnedPoints + currentPoints. @ Avinash K
  void updateUserPoints(int pointsToBeAdded) async {
    final User? currentUser = await getCurrentUser();
    DatabaseReference ref = FirebaseDatabase.instance.ref(
        "Users/${currentUser?.uid}"); // Access the record of the current user

    // Update the user's points
    await ref.update({"points": pointsToBeAdded});
  }

  @override
  Widget build(BuildContext context) {
    int difficultyMultiplier =
        0; // Multiplied with the point total based on difficulty (easy = 1, medium = 2, hard = 3, premium = 5)
    int earnedPoints = 0;

    // checking the type of question @Kelly O
    if (questions == eq) {
      difficultyMultiplier = 1;
    } else if (questions == mq) {
      difficultyMultiplier = 2;
    } else if (questions == hq) {
      difficultyMultiplier = 3;
    } else {
      difficultyMultiplier = 5;
    }
    final summaryData =
        getSummaryData(); // gets question data and maps it @Kelly O
    const numTotalQuestions = 3; // 3 questions per level. @ Avinash K
    int correctQuestions = summaryData
        .where(
          (data) => data['correct_answer'] == data['user_answer'],
        )
        .length;

    int currentPoints =
        0; // The amount of points the user had before answering the questions.

    // This is to get the int value of the Future<int> value from fetchUserPoints(). @ Avinash K
    Widget? getCurrentPoints() {
      return FutureBuilder<int>(
          future: fetchUserPoints(),
          builder: (context, snapshot) {
            currentPoints = snapshot.data ?? 0;
            return const Text("");
          });
    }

    earnedPoints = correctQuestions *
        10 *
        difficultyMultiplier; // Simpler calculation for earnedPoints @ Avinash K
    /*
    for(var data in summaryData){
      if(data['user_answer'] == data['correct_answer'])
          earnedPoints += 10 * difficultyMultiplier;
    }
    */
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Level Completed!',
                style: TextStyle(
                  fontSize: 30,
                )),
            const Divider(color: Colors.black),
            for (var i = 0; i < numTotalQuestions; i++)
              Row(
                children: [
                  if (width >= 400)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Text('Question ${i + 1}: ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ]),
                        Row(children: [
                          Text('${summaryData[i]['question']}',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ]),
                        Text(
                          'Answered: "${summaryData[i]['user_answer']}"',
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${i + 1}: ${summaryData[i]['question']}',
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Answered: "${summaryData[i]['user_answer']}"',
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 12,
                            )),
                      ],
                    ),
                  const Spacer(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            (summaryData[i]['user_answer'] ==
                                    summaryData[i]['correct_answer']
                                ? (10 * difficultyMultiplier).toString()
                                : '0'), //user ternary operator for conditions @Kelly O
                            style: TextStyle(
                              color: (summaryData[i]['user_answer'] ==
                                      summaryData[i]['correct_answer'])
                                  ? Colors.green
                                  : Colors.red,
                              fontWeight: FontWeight.bold,
                            ))
                      ]),
                  const SizedBox(width: 10)
                ],
              ),
            getCurrentPoints()!, // Set the value of currentPoints @Avinash K
            const Divider(color: Colors.black),
            Text(
                "Score: $correctQuestions/$numTotalQuestions = ${((correctQuestions / numTotalQuestions) * 100).toInt()}%"), // Score text with integer percentage
            Text("Points Earned: $earnedPoints"),
            ElevatedButton(
              // Collect Rewards button
              // onPressed: collectRewards,
              onPressed: () {
                int totalPoints = currentPoints + earnedPoints;
                updateUserPoints(
                    totalPoints); // Update the user's points with the addition of earnedPoints in the database.

                questions.shuffle();
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const MyHomePage();
                }));
                emptyPage();
              },
              child: const Text("Collect Rewards"),
            ),
          ],
        ),
      );
    });
  }
}
