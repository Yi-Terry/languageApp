import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/answer_button.dart';

// brings to easy level page @Kelly O

class EasyLevel extends StatefulWidget{
  const EasyLevel({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;
  List<QuizQuestion> getshuffledEasyQuestions(){
    final shuffledList = List.of(easyQuestions); //copies list
    shuffledList.shuffle(); //shuffles the copy in place
    return shuffledList; //returns the list values
  }
  @override
  State<EasyLevel> createState(){
    return _EasyLevelState();
  }
}

class _EasyLevelState extends State<EasyLevel>{
  var currentQuestionIndex = 0;
  List<QuizQuestion>? shuffledQuestions;
  @override
  void initState(){
     shuffledQuestions = widget.getshuffledEasyQuestions();
     super.initState();
  }
  void answerQuestion(String selectedAnswer){
    widget.onSelectAnswer(selectedAnswer);

    setState((){
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(context){
    final currentQuestion = shuffledQuestions![currentQuestionIndex];

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