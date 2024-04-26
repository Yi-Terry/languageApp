import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class InfoBox extends StatelessWidget {
  final String content;
  final String sectionTitle;
  final bool isPswd;

  const InfoBox(
      {super.key,
      required this.content,
      required this.sectionTitle,
      required this.isPswd});

//if content is password, hide text
//if edit button pressed on pswd, pop up field with new/confirm pswd

  void editContent(String newContent) async {
    // String value = '';
    // await showPrompt(
    //   content
    // )
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sectionTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                  //isPswd ? '' content.length : content,
                  content),
            ],
          ),
          Visibility(
            visible: isPswd,
            child: IconButton(
              onPressed: () {
                editContent('example');
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
