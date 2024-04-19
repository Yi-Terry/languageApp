import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/answer_button.dart';

class HardLevel extends StatefulWidget{
  const HardLevel({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<HardLevel> createState(){
    return _HardLevelState();
  }
}

class _HardLevelState extends State<HardLevel>{
  var questionType = 3;
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer){
    widget.onSelectAnswer(selectedAnswer);

    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
    final currentQuestion = hardQuestions[currentQuestionIndex];

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