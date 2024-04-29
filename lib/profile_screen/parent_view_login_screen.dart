import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_app/profile_screen/change_parent_view_password.dart';
import 'package:language_app/profile_screen/parent_view.dart';
import 'package:language_app/profile_screen/profile_screen.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ParentViewLogin extends StatefulWidget {
  const ParentViewLogin({super.key});

  @override
  State<ParentViewLogin> createState() {
    return ParentViewLoginState();
  }
}

class ParentViewLoginState extends State<ParentViewLogin> {
  //controller for user input
  var parentPasswordController = TextEditingController();

  //Firebase connection
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    //getting the current user
    return _auth.currentUser;
  }

  //retrieve current user's parent password
  Future<String> fetchUserParentPassword() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/parentPassword')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: parentPassword"; //otherwise return error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Parent View Login"),
      ),
      body: FutureBuilder(
          future: Future.wait([
            fetchUserParentPassword()
          ]), //async fetch parent pswd from database
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //loading snapshot
              return const Text("Loading...");
            } else if (snapshot.hasError) {
              return Text(
                'Error: ${snapshot.error}',
              );
            } else {
              final String userParentPassword = snapshot.data?.first ?? '';
              return Padding(
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      TextField(
                        obscureText: true,
                        controller: parentPasswordController,
                        decoration: const InputDecoration(hintText: "Password"),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            //process input
                            var parentPasswordInput =
                                parentPasswordController.text.trim();

                            //used to hash password
                            String hashPassword(String parentPasswordInput) {
                              final bytes = utf8.encode(
                                  parentPasswordInput); //converts inputed password to bytes
                              final digest =
                                  sha256.convert(bytes); //hashes the bytes
                              return digest
                                  .toString(); //returns the hashed password as a string
                            }

                            final hashedPassword = hashPassword(
                                parentPasswordInput); //saving the hashed password into this variable

                            //handle incorrect input
                            if (parentPasswordInput.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a password");
                              return;
                            } else if (hashedPassword != userParentPassword) {
                              Fluttertoast.showToast(
                                  msg: "Incorrect Password. Please try again.");
                            }
                            if (hashedPassword == userParentPassword) {
                              //if input correct, route to parent view
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const ParentViewPage();
                              }));
                            }
                          },
                          child: const Text("Login")),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Forgot password?'),
                          TextButton(
                              onPressed: () {
                                //route to change parent password page
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return const ChangeParentPassword(); //sends the user to the change password page
                                }));
                              },
                              child: const Text('Change password')),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to profile page
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const ProfilePage();
                          }));
                        },
                        child: const Text('Return to Profile'),
                      ),
                    ],
                  ));
            }
          }),
    );
  }
}
