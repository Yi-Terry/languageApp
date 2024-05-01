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
  
  } catch (e) {
    progressDialog.dismiss();
    Fluttertoast.showToast(msg: 'Something went wrong');
  }
} 