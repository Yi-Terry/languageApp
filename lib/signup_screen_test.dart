import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

class SignUpScreenTest extends StatefulWidget {
  const SignUpScreenTest({Key? key}) : super(key: key);

  @override
  _SignUpScreenStateTest createState() => _SignUpScreenStateTest();
}

class _SignUpScreenStateTest extends State<SignUpScreenTest> {
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold,)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: fullNameController, //creates text field controller that will take in the info from user for name
              decoration: const InputDecoration(
                hintText: 'Full Name',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController, //creates text field controller that will take in the info from user for email
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController, //creates text field controller that will take in the info from user for password
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: confirmController, //creates text field controller that will take in the info from user for confirming password
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton( //when this button is pressed, it will save all the info from controller to these variables
                onPressed: () async {
                  var fullName = fullNameController.text.trim(); 
                  var email = emailController.text.trim();
                  var password = passwordController.text.trim();
                  var confirmPass = confirmController.text.trim();

                  if (fullName.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      confirmPass.isEmpty) {
                    // show error toast

                    Fluttertoast.showToast(msg: 'Please fill all fields');
                    return;
                  }

                  if (password.length < 6) { //checking for weak password
                    // show error toast
                    Fluttertoast.showToast(
                        msg:
                            'Weak Password, at least 6 characters are required');

                    return;
                  }

                  if (password != confirmPass) { //password doesnt match confirmed one
                    // show error toast
                    Fluttertoast.showToast(msg: 'Passwords do not match');

                    return;
                  }

                  // request to firebase auth

                  ProgressDialog progressDialog = ProgressDialog(
                    context,
                    title: const  Text('Signing Up'),
                    message: const Text('Please wait'),
                  );

                  progressDialog.show();
                  try {


                    FirebaseAuth auth = FirebaseAuth.instance; //connecting to firebase

                    //creating user withe the data
                    UserCredential userCredential =
                        await auth.createUserWithEmailAndPassword(
                            email: email, password: password);

                    //if the user credential does not equal nothing
                    if (userCredential.user != null) {

                      // store user information in Realtime database
                      DatabaseReference userRef = FirebaseDatabase.instance.ref().child( 'Users');

                      String uid = userCredential.user!.uid; //getting the current user ID
                      int dt = DateTime.now().millisecondsSinceEpoch;

                      await userRef.child(uid).set({
                        'fullName': fullName,
                        'email': email,
                        'uid': uid,
                        'points': 0,
                        'parentPassword':'',
                        'password': password

                      });


                      Fluttertoast.showToast(msg: 'Success');

                      Navigator.of(context).pop();
                    } else {
                      Fluttertoast.showToast(msg: 'Failed');
                    }

                    progressDialog.dismiss();
                  
                  //exceptions if there are errors
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();
                    if (e.code == 'email-already-in-use') {
                      Fluttertoast.showToast(msg: 'Email is already in Use');
                    } else if (e.code == 'weak-password') {
                      Fluttertoast.showToast(msg: 'Password is weak');
                    }
                  } catch (e) {
                    progressDialog.dismiss();
                    Fluttertoast.showToast(msg: 'Something went wrong');
                  }
                },
                child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}