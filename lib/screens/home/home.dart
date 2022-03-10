import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ), 
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Feel free to study the file structure :)"),
      ),
    );
  }
}