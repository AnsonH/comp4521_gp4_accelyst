import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({ Key? key }) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
      ), 
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Todo"),
      ),
    );
  }
}