import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:language_app/profile_screen/profile_screen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

                if (password.isEmpty || confirmPassword.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                } else if (password.length < 6) {
                  Fluttertoast.showToast(
                      msg: 'Weak Password, at least 6 characters are required');
                  return;
                } else if (password != confirmPassword) {
                  Fluttertoast.showToast(msg: 'Passwords do not match');
                  return;
                } else if (currentPassword.isNotEmpty &&
                    password == currentPassword) {
                  Fluttertoast.showToast(
                      msg:
                          'Password cannot be the same as the previous password');
                } else {
                  ProgressDialog progressDialog = ProgressDialog(
                    context,
                    title: const Text('Signing Up'),
                    message: const Text('Please wait'),
                  );

                  progressDialog.show();

                  try {
                    String uid = await fetchUserID();

                    DatabaseReference userRef =
                        FirebaseDatabase.instance.ref().child('Users');

                    await userRef.child(uid).update({'password': password});
                    Fluttertoast.showToast(msg: 'Success');
                    Navigator.of(context).pop();

                    progressDialog.dismiss();
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();
                    if (e.code == 'weak-password') {
                      Fluttertoast.showToast(msg: 'Password is weak');
                    }
                  } catch (e) {
                    progressDialog.dismiss();
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
