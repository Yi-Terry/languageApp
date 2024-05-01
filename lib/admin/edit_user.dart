import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:numberpicker/numberpicker.dart';

final TextEditingController fullNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController pointsController = TextEditingController();
final TextEditingController rightQController = TextEditingController();
final TextEditingController totalQController = TextEditingController();
bool isPremium = false;
int rightQ = 0;
int totalQ = 0;

void editUserSheet(BuildContext context, id, fullName, email, points, premium, rightQuestions, totalQuestions){
  fullNameController.text = fullName;
  emailController.text = email;
  pointsController.text = points;
  isPremium = premium.toLowerCase() == 'true';
  rightQ = (rightQuestions != "null") ? int.parse(rightQuestions) : 0;
  totalQ = (totalQuestions != "null") ? int.parse(totalQuestions) : 0;

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
                Text("Question Stats:  ", 
                  style: TextStyle(
                  fontSize: 18.0,), 
                ),
                ScrollWheel(
                  currentValue: rightQ,
                  onValueChanged: (value) => rightQ = value,
                ),
                Text("/", 
                  style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold), 
                ),
                ScrollWheel(
                  currentValue: totalQ,
                  onValueChanged: (value) => totalQ = value,
                ),
              ],
            ),

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
                int wrongQ = totalQ - rightQ;

                if (fullName.isEmpty ||
                    email.isEmpty ||
                    points.isEmpty) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Please fill all fields');
                  return;
                }

                if (rightQ > totalQ) {
                  // show error toast
                  Fluttertoast.showToast(msg: 'Invalid Stat Configuration');
                  return;
                }

                // request to firebase auth
                ProgressDialog progressDialog = ProgressDialog(
                  context,
                  title: const Text('Updating Info...'),
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

                  userRef.child(id).child('statistics').update({
                    'questionsCompleted': totalQ,
                    'questionsCorrect': rightQ,
                    'questionsWrong': wrongQ,
                  });

                  Fluttertoast.showToast(msg: 'Success');

                  progressDialog.dismiss();
                
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

class ScrollWheel extends StatefulWidget {
  final int currentValue;
  final ValueChanged<int> onValueChanged;

  ScrollWheel({Key? key, required this.currentValue, required this.onValueChanged}) : super(key: key);

  @override
  ScrollWheelState createState() => ScrollWheelState();
}

class ScrollWheelState extends State<ScrollWheel> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    currentValue = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: currentValue,
          itemHeight: 30,
          minValue: 0,
          maxValue: 1000000000000000000,
          onChanged: (value) => setState(() {
            currentValue = value;
            widget.onValueChanged(value);
          }),
          selectedTextStyle: TextStyle(
            color: Colors.purple, 
            fontSize: 24, 
            fontWeight: FontWeight.bold
          ),
        ),
      ],
    );
  }
}