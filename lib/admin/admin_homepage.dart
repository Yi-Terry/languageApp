import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:language_app/admin/delete_user.dart';
import 'package:language_app/admin/user_creation.dart';
import 'package:language_app/admin/edit_user.dart';
import 'package:language_app/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              'Administrator Panel',
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
            padding: EdgeInsets.only(bottom: 100),
            itemBuilder: (context,snapshot,index,animation){
              // Get User Info
              var id = snapshot.child("uid").value.toString();
              var fullName = snapshot.child("fullName").value.toString();
              var email = snapshot.child("email").value.toString();
              var points = snapshot.child("points").value.toString();
              var premium = snapshot.child("premAccess").value.toString();

              var totalQuestions = snapshot.child("statistics").child("questionsCompleted").value.toString();
              var rightQuestions = snapshot.child("statistics").child("questionsCorrect").value.toString();
              var percentage = "";
              if(totalQuestions != "0"){
                try{
                  percentage = (double.parse(((double.parse(rightQuestions) / double.parse(totalQuestions)) * 100).toStringAsFixed(2))).toString();
                } catch (e) {
                  Fluttertoast.showToast(msg: 'Something went wrong');
                }
              }
              
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
                        Text(totalQuestions != "0" 
                          ? "Stats: " + rightQuestions + "/" + totalQuestions + " Questions (" + percentage + "%)"
                          : "Stats: " + rightQuestions + "/" + totalQuestions + " Questions",
                          style: TextStyle(
                          color: const Color.fromARGB(255, 0, 132, 4), 
                          fontSize: 17.0, 
                          fontWeight: FontWeight.bold), 
                        ),
                        Text(points + " Points", 
                          style: TextStyle(
                          color: Colors.green, 
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold), 
                        ),
                        Row(
                          children: [
                            Text("Premium Access: ", 
                              style: TextStyle(
                              color: Color.fromARGB(255, 236, 181, 0), 
                              fontSize: 18.0, 
                              fontWeight: FontWeight.bold), 
                            ),
                            Text(premium == "true" ? "Allowed" : "Not Allowed", 
                              style: TextStyle(
                              color: (premium == "true") ? Color.fromARGB(255, 0, 187, 234) : const Color.fromARGB(255, 192, 13, 0), 
                              fontSize: 18.0, 
                              fontWeight: FontWeight.bold), 
                            ),
                          ],
                        ),
                      ],
                    ), 
                    
                  // DropDown Menu
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_vert, size: 30,),
                    itemBuilder: (context) => [

                      // Update User Info
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: () => editUserSheet(context, id, fullName, email, points, premium, rightQuestions, totalQuestions),
                          leading: const Icon(Icons.edit, color: Color.fromARGB(255, 57, 133, 59),),
                          title: const Text("Edit", 
                            style: TextStyle(
                              color: Color.fromARGB(255, 57, 133, 59), 
                              fontSize: 16.0, 
                              fontWeight: FontWeight.bold
                            )
                          ),
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
                                  content: Text("This action cannot be undone.",
                                    style: TextStyle(fontSize: 16)),
                                  actions: [
                                    // 'Cancel' option
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        Navigator.pop(context);
                                      },
                                      child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                    ),
                                    // 'Delete' option
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                        deleteUser(context, id);
                                        Navigator.pop(context);
                                      },
                                      child: Text('Delete', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red)),
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