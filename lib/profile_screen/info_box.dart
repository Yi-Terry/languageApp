import 'package:flutter/material.dart';
import 'package:language_app/profile_screen/change_password.dart';

class InfoBox extends StatelessWidget {
  final String content;
  final String sectionTitle;
  final bool isPswd;

  //set required input for InfoBox widget
  const InfoBox(
      {super.key,
      required this.content,
      required this.sectionTitle,
      required this.isPswd});

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
                //take input for title
                sectionTitle,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(isPswd
                  ? '******'
                  : content), //take content input, obscure if content is a password
            ],
          ),
          Visibility(
            //only display edit password button if content is a password
            visible: isPswd,
            child: IconButton(
              onPressed: () {
                //button to route to change password page
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const ChangePassword();
                }));
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }
}
