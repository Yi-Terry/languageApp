import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmController = TextEditingController();

void userCreationSheet(BuildContext context){
  // User Creation Pop-up Sheet
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context, 
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20, 
          right: 20, 
          left: 20, 
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                "Create a New User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Text Fields
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            TextField(
              controller: confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
              ),
            ),
            
            const SizedBox(height: 20,),
            
            // "Create" Button
            ElevatedButton(
              onPressed: () async {
                var fullName = fullNameController.text.trim(); 
                var email = emailController.text.trim();
                var password = passwordController.text.trim();
                var confirmPass = confirmController.text.trim();

                if (fullName.isEmpty || email.isEmpty ||
                    password.isEmpty || confirmPass.isEmpty) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }

                if (password.length < 6) { //checking for weak password
                  // show error toast
                  Fluttertoast.showToast(msg: 'Weak Password, at least 6 characters are required');
                  return;
                }

                if (password != confirmPass) { //password doesnt match confirmed one
                  // show error toast
                  Fluttertoast.showToast(msg: 'Passwords do not match');
                  return;
                }

                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  title: const  Text('Creating User...'),
                  message: const Text('Please wait'),
                );
                progressDialog.show();

                try {

                  FirebaseAuth auth = FirebaseAuth.instance; //connecting to firebase

                  //creating user with the data
                  UserCredential userCredential =
                      await auth.createUserWithEmailAndPassword(
                          email: email, password: password);

                  //if the user credential does not equal nothing
                  if (userCredential.user != null) {

                    // store user information in Realtime database
                    DatabaseReference userRef = FirebaseDatabase.instance.ref().child( 'Users');

                    String uid = userCredential.user!.uid; //getting the current user ID

                    await userRef.child(uid).set({
                      'fullName': fullName,
                      'email': email,
                      'uid': uid,
                      'points': 0,
                      'parentPassword':'',
                      'password': password,
                      'premAccess': false,
                    });

                    await userRef.child(uid).child('statistics').set({
                      'questionsCompleted': 0,
                      'questionsCorrect': 0,
                      'questionsWrong': 0,
                    });

                    Fluttertoast.showToast(msg: 'Success');

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

                fullNameController.clear();
                emailController.clear();
                passwordController.clear();
                confirmController.clear();
                Navigator.pop(context);
              }, 
              child: const Text("Create")),
          ],
        ),
      );
    });
}