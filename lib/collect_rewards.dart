import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';

class CollectRewardsPage extends StatelessWidget {

  const CollectRewardsPage({super.key, required this.questions, required this.chosenAnswers, required this.collectRewards});

  final List<QuizQuestion> questions;  // could be easy, medium, hard, premium questions
  final List<String> chosenAnswers;
  final void Function() collectRewards;

  List<Map<String, Object>> getSummaryData(){ //mapping of information
    final List<Map<String, Object>> summary = [];

    for(var i = 0; i < chosenAnswers.length; i++){
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }
    return summary;
  }


  @override
  Widget build (BuildContext context) {
    int difficultyMultiplier = 0; // Multiplied with the point total based on difficulty (easy = 1, medium = 2, hard = 3, premium = 5)

    if(questions == easyQuestions){
      difficultyMultiplier = 1;
    }
    else if(questions == mediumQuestions){
      difficultyMultiplier = 2;
    }
    else if(questions == hardQuestions){
      difficultyMultiplier = 3;
    }
    else{
      difficultyMultiplier = 5;
    }
    final summaryData = getSummaryData(); // gets question data and maps it 
    final numTotalQuestions = questions.length;
    int correctQuestions = summaryData.where(
      (data) => data['correct_answer'] == data['user_answer'],).length;
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
                  for (var i = 0; i < numTotalQuestions; i++)
                    ListTile ( // Each ListTile (scroll item) contains the question number and the points earned. 
                      leading: Text("Question $i: ${summaryData[i]['question']}; Answer: ${summaryData[i]['user_answer']}" ),
                      trailing: 
                        Text(
                          (summaryData[i]['user_answer'] == summaryData[i]['correct_answer'] 
                          ? (10 * difficultyMultiplier).toString() 
                          : '0'
                          ) //user ternary operator for conditions @Kelly O
                        ),
                         //Correct question: 10 pts * difficulty multiplier. Incorrect question: 0 pts.
                    )
                ],
              ),
              const Divider(color: Colors.black),
              Text("Score: $correctQuestions/${questions.length} = ${(correctQuestions/questions.length) * 100}"), // Score text 
              ElevatedButton(       // Collect Rewards button
                onPressed: collectRewards,
                child: const Text("Collect Rewards"),
              ),
            ]
          ),
        );
  }
}