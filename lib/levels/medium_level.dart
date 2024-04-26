import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/widgets/answer_button.dart';

// brings to medium level page @Kelly O

class MediumLevel extends StatefulWidget{
  const MediumLevel({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<MediumLevel> createState(){
    return _MediumLevelState();
  }
}

class _MediumLevelState extends State<MediumLevel>{
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer){
    widget.onSelectAnswer(selectedAnswer);

    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
    final currentQuestion = mq[currentQuestionIndex];

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