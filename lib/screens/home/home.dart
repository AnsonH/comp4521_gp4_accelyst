import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: handleClick,
              offset: const Offset(0, 52),
              itemBuilder: (BuildContext context) {
                return ['Logout', 'Settings'].map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice, child: Text(choice));
                }).toList();
              })
        ],
      ),
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width *
          0.4, // this line allows screen swipe to slide out drawer
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Feel free to study the file structure :)"),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
