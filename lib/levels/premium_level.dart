import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/widgets/answer_button.dart';

// brings to easy level page @Kelly O

class PremiumLevel extends StatefulWidget{
  const PremiumLevel({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;
  List<QuizQuestion> getshuffledEasyQuestions(){
    final shuffledList = List.of(easyQuestions); //copies list
    shuffledList.shuffle(); //shuffles the copy in place
    return shuffledList; //returns the list values
  }
  @override
  State<PremiumLevel> createState(){
    return _PremiumLevelState();
  }
}

class _PremiumLevelState extends State<PremiumLevel>{
  var currentQuestionIndex = 0;
 
  void answerQuestion(String selectedAnswer){
    widget.onSelectAnswer(selectedAnswer);

    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
    final currentQuestion = pq[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            currentQuestion.text,
            style: const TextStyle(
              fontSize: 30,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ...currentQuestion.getShuffledAnswers().map((item){
            return AnswerButton(
              answerText: item,
              onTap: (){
                answerQuestion(item);
              }
            );
          }),
        ],
      ),
    );
  }
}