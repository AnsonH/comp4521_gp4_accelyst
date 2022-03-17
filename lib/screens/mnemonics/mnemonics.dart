import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Mnemonics extends StatefulWidget {
  const Mnemonics({Key? key}) : super(key: key);

  @override
  State<Mnemonics> createState() => _MnemonicsState();
}

class _MnemonicsState extends State<Mnemonics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mnemonics"), actions: <Widget>[
        PopupMenuButton<String>(
            onSelected: (String value) {},
            offset: Offset(0, 52),
            itemBuilder: (BuildContext context) {
              return {
                'Add memory method',
                'Refresh vocab list',
                'Take new photo'
              }.map((String choice) {
                return PopupMenuItem<String>(
                    value: choice, child: Text(choice));
              }).toList();
            })
      ]),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Mnemonics"),
      ),
    );
  }
}
