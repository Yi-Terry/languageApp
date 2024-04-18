import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{

  const LoginScreen(this.login, {Key? key}): super(key: key);
  final void Function() login;


  @override
  Widget build(context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 16,),
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
              )
          ]
        ),
        ),
    );
  }
}