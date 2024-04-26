import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

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

    userRef.child(id).remove();

    Fluttertoast.showToast(msg: 'Success');

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
