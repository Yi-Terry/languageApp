import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
//import 'package:language_app/home_screen/my_home_page.dart';
//import 'package:language_app/language_app.dart';

class UserCreation extends StatelessWidget {
  const UserCreation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print("button pressed");
        },
          icon: Icon(Icons.add),
          label: Text("Create User"),
        ),
      appBar: AppBar(
        title: Row(children: [
            Text(
              'Create a New User',
              style: TextStyle(
                //color: Colors.purple,
                fontSize: 30.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
