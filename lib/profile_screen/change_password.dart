import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:language_app/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  ChangePasswordState createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

//Firebase connection
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    //getting the current user
    return _auth.currentUser;
  }

  //retrieve current user's UID
  Future<String> fetchUserID() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/uid')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: uid"; //otherwise return error
  }

  //retrieve current user's password
  Future<String> fetchUserPassword() async {
    final User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      final DatabaseReference ref =
          FirebaseDatabase.instance.ref(); //referencing database
      final DatabaseEvent event = await ref
          .child('Users/${currentUser.uid}/password')
          .once(); //going to the table to get this
      final DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        return snapshot.value as String; //return value as string
      }
    }
    return "Could not fetch value: password"; //otherwise return error
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Change Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(padding: EdgeInsets.all(8), children: [
          TextField(
            controller:
                passwordController, //creates text field controller that will take in the info from user for password
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
          ),
          TextField(
            controller:
                confirmController, //creates text field controller that will take in the info from user for confirming password
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Confirm Password',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var password = passwordController.text.trim();
                var confirmPassword = confirmController.text.trim();
                String currentPassword = await fetchUserPassword();

                //used to hash password
                String hashPassword(
                  String password,
                ) {
                  final bytes = utf8
                      .encode(password); //converts inputed password to bytes
                  final digest = sha256.convert(bytes); //hashes the bytes
                  return digest
                      .toString(); //returns the hashed password as a string
                }

                //used to hash confirmPassword
                String hashConfirmPassword(
                  String confirmPassword,
                ) {
                  final bytes = utf8.encode(
                      confirmPassword); //converts inputed password to bytes
                  final digest = sha256.convert(bytes); //hashes the bytes
                  return digest
                      .toString(); //returns the hashed password as a string
                }

                final hashedPassword = hashPassword(
                    password); //saving the hashed password into this variable

                final hashedConfirmPassword =
                    hashConfirmPassword(confirmPassword);

                //handle incorrect input conditions
                if (hashedPassword.isEmpty || hashedConfirmPassword.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                } else if (hashedPassword.length < 6) {
                  Fluttertoast.showToast(
                      msg: 'Weak Password, at least 6 characters are required');
                  return;
                } else if (hashedPassword != hashedConfirmPassword) {
                  Fluttertoast.showToast(msg: 'Passwords do not match');
                  return;
                } else if (currentPassword.isNotEmpty &&
                    hashedPassword == currentPassword) {
                  Fluttertoast.showToast(
                      msg:
                          'Password cannot be the same as the previous password');
                } else {
                  try {
                    //fetch current user uid
                    String uid = await fetchUserID();

                    //reference database
                    DatabaseReference userRef =
                        FirebaseDatabase.instance.ref().child('Users');

                    await userRef
                        .child(uid)
                        .update({'password': hashedPassword});

                    Fluttertoast.showToast(msg: 'Success');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const ProfilePage();
                    }));
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      Fluttertoast.showToast(msg: 'Password is weak');
                    }
                  } catch (e) {
                    Fluttertoast.showToast(msg: 'Something went wrong');
                  }
                }
              },
              child: Text('Submit', style: TextStyle(fontSize: 16))),
          ElevatedButton(
            onPressed: () {
              // Navigate to profile page
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ProfilePage();
              }));
            },
            child: const Text(
              'Return to Profile',
              style: TextStyle(fontSize: 16),
            ),
          )
        ])));
  }
}
