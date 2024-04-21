import 'package:flutter/material.dart';

//answer buttons for each quiz question @Kelly o

class AnswerButton extends StatelessWidget{
  const AnswerButton({
    super.key,
    required this.answerText,
    required this.onTap,
  });

  final String answerText;
  final void Function() onTap;

  @override
  Widget build(context){
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 40,
        ),
        backgroundColor: Color.fromARGB(160, 39, 255, 60),
        foregroundColor: Colors.white,
      ),
      child: Text(
        answerText,
        textAlign: TextAlign.center,
        )
    );
  }
}