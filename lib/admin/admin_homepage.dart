import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:language_app/admin/delete_user.dart';
import 'package:language_app/admin/user_creation.dart';
import 'package:language_app/admin/edit_user.dart';
import 'package:language_app/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';

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
            icon: const Icon(Icons.logout, size: 30,)),
            SizedBox(width: 15,),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(child: FirebaseAnimatedList(query: ref, 
            itemBuilder: (context,snapshot,index,animation){
              // Get User Info
              var id = snapshot.child("uid").value.toString();
              var fullName = snapshot.child("fullName").value.toString();
              var email = snapshot.child("email").value.toString();
              var points = snapshot.child("points").value.toString();

              // User Card Format
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: 
                    Text(fullName, 
                      style: TextStyle(
                      color: Colors.blue, 
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold), 
                    ),
                  subtitle: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(email, 
                          style: TextStyle(
                          color: Color.fromARGB(255, 233, 140, 0), 
                          fontSize: 16.0, 
                          fontWeight: FontWeight.bold), 
                        ),
                        Text(points + " points", 
                          style: TextStyle(
                          color: Colors.green, 
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold), 
                        ),
                      ],
                    ), 
                    
                  // DropDown Menu
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 30,),
                    itemBuilder: (context) => [

                      // Update User Data
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: () => editUserSheet(context, id, fullName, email, points),
                          leading: const Icon(Icons.edit, color: Color.fromARGB(255, 57, 133, 59),),
                          title: const Text("Edit", style: TextStyle(color: Color.fromARGB(255, 57, 133, 59), fontSize: 16.0, fontWeight: FontWeight.bold)),
                        )
                      ),

                      // Delete User
                      PopupMenuItem(
                        value: 2,
                        child: ListTile(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text('Delete User?',
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
                                        deleteUser(context, id);
                                      },
                                      child: Text('Yes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                  ],
                                );
                              });
                          },
                          leading: const Icon(Icons.delete, color: Colors.red,),
                          title: const Text("Delete", style: TextStyle(color: Colors.red, fontSize: 16.0, fontWeight: FontWeight.bold)),
                        )
                      ),
                    ],
                  ),
                ),
              );
          }))
        ],
      ),
    );
  }
}
