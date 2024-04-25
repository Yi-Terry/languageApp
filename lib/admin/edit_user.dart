import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController pointsController = TextEditingController();


Future<User?> getUserByUid(String uid) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  try {
    // Perform sign-in to initialize Firebase Authentication
    await auth.signInAnonymously();
    
    // Get the user by UID
    User? user = auth.currentUser;
    
    return user;
  } catch (e) {
    print("Error getting user by UID: $e");
    return null;
  }
}

// // Function to update user's email by UID
// void async function updateUserEmail(uid, newEmail) {
//   try {
//     // Get user record
//     const userRecord = await admin.auth().getUser(uid);

//     // Update user's email
//     await admin.auth().updateUser(uid, {
//       email: newEmail,
//       emailVerified: false // You may need to verify the new email
//     });

//     print('yay');
//   } catch (error) {
//     print('Error updating email');
//   }
// }




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

                    User? user = await getUserByUid(id);

                    if (user != null) {
                      try {
                        // Update the email for the user
                        await user.updateEmail(email);
                        print('Email updated successfully');
                      } catch (e) {
                        print('Error updating email: $e');
                      }
                    } else {
                      print('User not found or error occurred while fetching user.');
                    }



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