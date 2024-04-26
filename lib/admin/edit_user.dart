import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController pointsController = TextEditingController();

void editUserSheet(BuildContext context, id, fullName, email, points){
  fullNameController.text = fullName;
  emailController.text = email;
  pointsController.text = points;
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
                "Edit User Info",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
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
              keyboardType: TextInputType.number,
              controller: pointsController,
              decoration: const InputDecoration(
                labelText: "Points",
              ),
            ),

            const SizedBox(height: 20,),
            
            ElevatedButton(
              onPressed: () async {
                var fullName = fullNameController.text.trim(); 
                var email = emailController.text.trim();
                var points = pointsController.text.trim();

                if (fullName.isEmpty ||
                    email.isEmpty ||
                    points.isEmpty) {
                  // show error toast

                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }

                // request to firebase auth
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  title: const  Text('Updating Info...'),
                  message: const Text('Please wait'),
                );

                progressDialog.show();
                try {


                  //connecting to firebase
                  DatabaseReference userRef = FirebaseDatabase.instance.ref().child('Users');

                  //if the user credential does not equal nothing
                  if (true) {

                    userRef.child(id).update({
                      'fullName': fullName,
                      'email': email,
                      'points': int.parse(points),
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
                  }
                } catch (e) {
                  progressDialog.dismiss();
                  Fluttertoast.showToast(msg: 'Something went wrong');
                }
                Navigator.pop(context);
              }, 
              child: const Text("Update")),
          ],
        ),
      );
    });
}