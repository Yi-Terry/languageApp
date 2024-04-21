import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/admin/user_creation.dart';
//import 'package:language_app/home_screen/my_home_page.dart';
//import 'package:language_app/language_app.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserCreation(),
                ),
              );
          print("button pressed");
        },
          icon: Icon(Icons.add),
          label: Text("Create User", style: TextStyle(color: Colors.purple, fontSize: 18.0, fontWeight: FontWeight.bold),),
        ),
      appBar: AppBar(
        title: Row(children: [
            Text(
              'Administator Page',
              style: TextStyle(
                color: Colors.purple,
                fontSize: 32.0,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30,)
          ],),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, size: 30.0,),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          )
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
                    Text("Jewels: 4378", 
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
