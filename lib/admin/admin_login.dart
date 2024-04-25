import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_app/admin/admin_homepage.dart';
import 'package:language_app/home_screen/my_home_page.dart';
import 'package:language_app/signup_screen.dart';
import 'package:ndialog/ndialog.dart';
import 'package:language_app/signup_screen_test.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AdminLogin> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administrator Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
             TextField(
               controller: usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 10,),

             TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),

            const SizedBox(height: 10,),

            ElevatedButton(onPressed: () async {

              var usernameField = usernameController.text.trim();
              var passwordField = passwordController.text.trim();
              if( usernameField.isEmpty || passwordField.isEmpty ){
                // show error toast
                Fluttertoast.showToast(msg: 'Please fill all fields');
                return;
              }

              ProgressDialog progressDialog = ProgressDialog(
                context,
                title: const  Text('Logging In'),
                message: const Text('Please wait'),
              );

              progressDialog.show();

              //tries to sign in
              try{

                var username;
                var password;

                //connects to firebase
                DatabaseReference adminRef = FirebaseDatabase.instance.ref().child('Admin');               

                final snapshot = await adminRef.get();

                if (snapshot.exists) {
                  setState(() {
                    username = snapshot.child("username").value.toString();
                    password = snapshot.child("password").value.toString();
                  });
                  
                }

                //if the admin credential is correct 
                if((usernameField == username)  && (passwordField == password)){
                  progressDialog.dismiss();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){

                      return const AdminHomePage();
                    }));
                }else{
                  progressDialog.dismiss();
                  Fluttertoast.showToast(msg: 'Invalid Credentials');
                }
              }
              //if another other sort of error
              catch(e){
                Fluttertoast.showToast(msg: 'Something went wrong');
                progressDialog.dismiss();
              }
            }, 
            child:const  Text('Login')),
          ],
        ),
      ),
    );
  }
}