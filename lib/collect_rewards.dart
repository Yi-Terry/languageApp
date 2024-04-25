import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/home_screen/my_home_page.dart';

class CollectRewardsPage extends StatelessWidget {
  const CollectRewardsPage(
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

    for (var i = 0; i < chosenAnswers.length; i++) {
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

  @override
  Widget build(BuildContext context) {
    int difficultyMultiplier = 0; // Multiplied with the point total based on difficulty (easy = 1, medium = 2, hard = 3, premium = 5)
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
    final numTotalQuestions = questions.length;
    int correctQuestions = summaryData
        .where(
          (data) => data['correct_answer'] == data['user_answer'],
        ).length;
    for(var data in summaryData){
      if(data['user_answer'] == data['correct_answer'])
        earnedPoints += 10 * difficultyMultiplier;
      }
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
                    Text(
                      'Answered: "${summaryData[i]['user_answer']}"',
                      softWrap: true,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text((summaryData[i]['user_answer'] ==
                                  summaryData[i]['correct_answer']
                              ? (10 * difficultyMultiplier).toString()
                              : '0'), //user ternary operator for conditions @Kelly O
                            style: TextStyle(
                              color: (summaryData[i]['user_answer'] ==
                                  summaryData[i]['correct_answer']) ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            )
                          )
                    ]),
                const SizedBox(width: 10)
              ],
            ),
          const Divider(color: Colors.black),
          Text(
              "Score: $correctQuestions/${questions.length} = ${(correctQuestions / questions.length) * 100}"), // Score text
          Text("Points Earned: $earnedPoints"),
          ElevatedButton(
            // Collect Rewards button
            // onPressed: collectRewards,
            onPressed: () {
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
  }
}
