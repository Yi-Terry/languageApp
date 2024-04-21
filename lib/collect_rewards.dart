import 'package:flutter/material.dart';

class CollectRewardsPage extends StatelessWidget {

  final List<String> questions;  // could be easy, medium, hard, premium questions
  const CollectRewardsPage({super.key, required this.questions});

  @override
  Widget build (BuildContext context) {
    int correctQuestions = 0;
    int difficultyMultiplier = 1; // Multiplied with the point total based on difficulty (easy = 1, medium = 2, hard = 3, premium = 5)
        return 
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 100),    // Somewhat centers everything on the page
          child: Column(
            children: [
              const Text("Level Complete!"),
              const Divider(color: Colors.black),
              ListView(
                shrinkWrap: true, // Prevents the ListView from taking infinite vertical space. **DOES NOT SUPPORT MORE THAN 8 QUESTIONS PER LEVEL**
                children: [
                  for (var i = 0; i < questions.length; i++)
                    ListTile (      // Each ListTile (scroll item) contains the question number and the points earned. 
                      leading: Text("Question $i"),
                      trailing: Text("ptCount"), //Correct question: 10 pts * difficulty multiplier. Incorrect question: 0 pts.
                    )
                ],
              ),
              const Divider(color: Colors.black),
              Text("Score: $correctQuestions/${questions.length} = ${correctQuestions/questions.length}%"), // Score text
              ElevatedButton(       // Collect Rewards button
                onPressed: () {
                  print("Rewards 'collected'");
                },
                child: const Text("Collect Rewards"),
              )
            ]
          ),
        );
  }
}