import 'package:flutter/material.dart';
import 'package:language_app/profile_screen/parent_view_login_screen.dart';

class ChangeParentPassword extends StatefulWidget {
  const ChangeParentPassword({super.key});

  @override
  ChangeParentPasswordState createState() => ChangeParentPasswordState();
}

class ChangeParentPasswordState extends State<ChangeParentPassword> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: ListView(children: [
      ElevatedButton(
        onPressed: () {
          // Navigate to home page
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const ParentViewLogin();
          }));
        },
        child: const Text('Return to Login'),
      )
    ])));
  }
}
