import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/answer_button.dart';

class EasyLevel extends StatefulWidget{
  const EasyLevel({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  @override
  State<EasyLevel> createState(){
    return _EasyLevelState();
  }
}

class _EasyLevelState extends State<EasyLevel>{
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer){
    widget.onSelectAnswer(selectedAnswer);

    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
    final currentQuestion = easyQuestions[currentQuestionIndex];

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