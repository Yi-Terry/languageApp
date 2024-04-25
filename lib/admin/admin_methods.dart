import 'dart:html';

import 'package:firebase_database/firebase_database.dart';

class AdminMethods{
  
  // Future addUserInfo(Map<dynamic, dynamic> userData) async{
  //   DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('Users');
  //   usersRef.once().then((DataSnapshot snapshot) {
  //     if (snapshot.value != null) {
  //       Map<dynamic, dynamic> userData = snapshot.value;
  //       usersData.forEach((key, value) {
  //         String userId = key;
  //         String name = value['name'];
  //         String email = value['email'];
  //         String password = value['password'];

  //         // Use the retrieved user data
  //         print('User ID: $userId');
  //         print('Name: $name');
  //         print('Email: $email');
  //         print('Password: $password');
  //         print('---');
  //       });
  //     } else {
  //       print('No users found');
  //     }
  //   }).catchError((error) {
  //     print('Failed to list users: $error');
  //   });
  // }

  // Future getUserInfo() async{
  //   DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  //   String name = 'temp';
  //   ref.onValue.listen(
  //     (event) {
  //       setState(() {
  //         name = event.snapshot.value.toString();
  //       });
  //     },
  //   );
  // }




}