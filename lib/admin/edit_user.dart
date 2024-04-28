import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController pointsController = TextEditingController();
bool isPremium = false;

void editUserSheet(BuildContext context, id, fullName, email, points, premium){
  fullNameController.text = fullName;
  emailController.text = email;
  pointsController.text = points;
  isPremium = premium.toLowerCase() == 'true';

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

            const SizedBox(height: 10,),

            Row(
              children: [
                Text("Premium Access:  ", 
                  style: TextStyle(
                  fontSize: 18.0,), 
                ),
                const SizedBox(width: 2,),
                ToggleSlider(),
              ],
            ),

            const SizedBox(height: 10,),
            
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

                  userRef.child(id).update({
                    'fullName': fullName,
                    'email': email,
                    'points': int.parse(points),
                    'premAccess': isPremium,
                  });

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
                Navigator.pop(context);
                Navigator.pop(context);
              }, 
              child: const Text("Update", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
          ],
        ),
      );
    });
}

class ToggleSlider extends StatefulWidget {
  @override
  _ToggleSliderState createState() => _ToggleSliderState();
}

class _ToggleSliderState extends State<ToggleSlider> {

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isPremium,
      onChanged: (value) {
        setState(() {
          isPremium = value;
        });
      },
      activeTrackColor: Colors.lightGreenAccent,
      activeColor: Colors.green,
    );
  }
}