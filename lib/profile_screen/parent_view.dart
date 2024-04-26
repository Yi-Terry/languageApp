import 'package:flutter/material.dart';

class ParentViewPage extends StatefulWidget {
  const ParentViewPage({super.key});

  @override
  State<ParentViewPage> createState() {
    return ParentViewPageState();
  }
}

class ParentViewPageState extends State<ParentViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "This is the parent page",
        textAlign: TextAlign.center,
      ),
    );
  }
}
