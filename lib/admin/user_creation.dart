import 'package:flutter/material.dart';
final TextEditingController nameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

void userCreationSheet(BuildContext context){
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.blue[100],
    context: context, 
    builder: (BuildContext) {
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
                "Create a New User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextField(
              controller: nameController,
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
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                

                nameController.clear();
                emailController.clear();
                passwordController.clear();
                Navigator.pop(context);
              }, 
              child: const Text("Create")),
          ],
        ),
      );
    });
}