import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';


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



void deleteUser(BuildContext context, id){

  // request to firebase auth
  ProgressDialog progressDialog = ProgressDialog(
    context,
    title: const  Text('Deleting User...'),
    message: const Text('Please wait'),
  );

  progressDialog.show();
  try {

    //connecting to firebase
    DatabaseReference userRef = FirebaseDatabase.instance.ref().child('Users');

    //if the user credential does not equal nothing
    if (true) {

      userRef.child(id).remove();

      //User? user = await getUserByUid(id);

      // if (user != null) {
      //   try {
      //     // Update the email for the user
      //     await user.updateEmail(email);
      //     print('Email updated successfully');
      //   } catch (e) {
      //     print('Error updating email: $e');
      //   }
      // } else {
      //   print('User not found or error occurred while fetching user.');
      // }

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
} 
