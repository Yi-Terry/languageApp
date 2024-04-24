import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:language_app/language_app.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset('dash.png'),
            Text(
              'Welcome to BeyondLanguage!',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
              //button to bring to HomePage @Kelly O
              onPressed: () {},
              icon: const Icon(Icons.arrow_circle_right_outlined),
              label: const Text('Click to Begin'),
            ),
            const SignOutButton(),
          ],
        ),
      ),
    );
  }
}
