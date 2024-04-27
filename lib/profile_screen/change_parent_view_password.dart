import 'package:flutter/material.dart';
import 'package:language_app/profile_screen/parent_view_login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ndialog/ndialog.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChangeParentPassword extends StatefulWidget {
  const ChangeParentPassword({Key? key}) : super(key: key);

  @override
  ChangeParentPasswordState createState() => ChangeParentPasswordState();
}

class ChangeParentPasswordState extends State<ChangeParentPassword> {
  var parentPasswordController = TextEditingController();
  var parentConfirmController = TextEditingController();

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
    return "Could not fetch value: password"; //otherwise return error
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Create Or Change Parent Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(padding: EdgeInsets.all(8), children: [
          TextField(
            controller:
                parentPasswordController, //creates text field controller that will take in the info from user for password
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Parent Password',
            ),
          ),
          TextField(
            controller:
                parentConfirmController, //creates text field controller that will take in the info from user for confirming password
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Confirm Parent Password',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                var parentPassword = parentPasswordController.text.trim();
                var confirmParentPassword = parentConfirmController.text.trim();
                String curentParentPassword = await fetchUserParentPassword();

                if (parentPassword.isEmpty || confirmParentPassword.isEmpty) {
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                } else if (parentPassword.length < 6) {
                  Fluttertoast.showToast(
                      msg: 'Weak Password, at least 6 characters are required');
                  return;
                } else if (parentPassword != confirmParentPassword) {
                  Fluttertoast.showToast(msg: 'Passwords do not match');
                  return;
                } else if (curentParentPassword.isNotEmpty &&
                    parentPassword == curentParentPassword) {
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

                    await userRef
                        .child(uid)
                        .update({'parentPassword': parentPassword});
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
              // Navigate to home page
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const ParentViewLogin();
              }));
            },
            child: const Text(
              'Return to Login',
              style: TextStyle(fontSize: 16),
            ),
          )
        ])));
  }
}
