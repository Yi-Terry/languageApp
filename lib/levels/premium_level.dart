import 'package:flutter/material.dart';
import 'package:language_app/widgets/questions.dart';
import 'package:language_app/widgets/answer_button.dart';
import "package:audioplayers/audioplayers.dart";

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
          // Check if the question is an audio question, and if it is, choose the correct audio to play. @ Avinash K
          if (currentQuestion.text == "Translate the following sentence:")    // No space after colon -> AudioQuestion1
            createAudioButton("audios/AudioQuestion1.mp3"),
          if (currentQuestion.text == "Translate the following sentence: ")   // 1 space after colon -> AudioQuestion2
            createAudioButton("audios/AudioQuestion2.mp3"),
          if (currentQuestion.text == "Translate the following sentence:  ")  // 2 spaces after colon -> AudioQuestion3
            createAudioButton("audios/AudioQuestion3.mp3"),
          if (currentQuestion.text == "Translate the following sentence:   ") // 3 spaces after colon -> AudioQuestion4
            createAudioButton("audios/AudioQuestion4.mp3"),
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

  // Creates an audio button for audio questions using the specified name of the corresponding audio file.
  IconButton createAudioButton(String fileName) {
    return IconButton(
              onPressed: () {
                final player = AudioPlayer();
                player.play(AssetSource(fileName));
              },
              icon: Icon(Icons.play_arrow_rounded, size: 20),
              alignment: AlignmentDirectional.center,
            );
  }
}

