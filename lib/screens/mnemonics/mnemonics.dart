import 'package:flutter/material.dart';

class Mnemonics extends StatefulWidget {
  const Mnemonics({ Key? key }) : super(key: key);

  @override
  State<Mnemonics> createState() => _MnemonicsState();
}

class _MnemonicsState extends State<Mnemonics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mnemonics"),
      ), 
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Mnemonics"),
      ),
    );
  }
}