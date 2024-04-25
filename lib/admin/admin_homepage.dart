import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/admin/user_creation.dart';
import 'package:language_app/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:language_app/home_screen/my_home_page.dart';
//import 'package:language_app/language_app.dart';

DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => userCreationSheet(context),
        
          icon: Icon(Icons.add),
          label: Text("Create User", style: TextStyle(color: Colors.purple, fontSize: 18.0, fontWeight: FontWeight.bold),),
        ),
      appBar: AppBar(
        title: Row(children: [
            Text(
              'Administrator Page',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 32.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30,)
          ],),
        actions: [
          //Log out Button
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Log Out?',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }));
                          },
                          child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ],
                    );
                  });
              },
            icon: const Icon(Icons.logout)),
            SizedBox(width: 10,),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
        child: Column(
          children: [
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Expanded(child: FirebaseAnimatedList(query: ref, 
                    // itemBuilder: (context,snapshot,index,animation){
                    //   return ListTile(
                    //     title: 
                    //         Text("Name: " + snapshot.child("fullName").value.toString(), 
                    //         style: TextStyle(
                    //         color: Colors.blue, 
                    //         fontSize: 20.0, 
                    //         fontWeight: FontWeight.bold), 
                    //     ),
                    //   );
                    // }))


                    Row(
                      children: [
                        Text("Name: Benjamin Smith", 
                          style: TextStyle(
                            color: Colors.blue, 
                            fontSize: 20.0, 
                            fontWeight: FontWeight.bold), 
                        ),
                        Spacer(),
                        Icon(Icons.edit, color: Colors.green),
                        SizedBox(width: 10.0,),
                        Icon(Icons.delete, color: Colors.red)
                      ],
                    ),
                    Text("Email: benSmith@gmail.com", 
                      style: TextStyle(
                        color: Colors.orange, 
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold), 
                    ),
                    Text("Points: 4378", 
                      style: TextStyle(
                        color: Colors.blue, 
                        fontSize: 20.0, 
                        fontWeight: FontWeight.bold), 
                      )
                    ],
                  ), 
                ),
            )
          ],
        )
      )
    );
  }
}
