import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Music extends StatefulWidget {
  const Music({Key? key}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
              onSelected: (String value) {},
              offset: const Offset(0, 52),
              itemBuilder: (BuildContext context) {
                return ['I love music', '周杰倫', '張敬軒'].map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice, child: Text(choice));
                }).toList();
              })
        ],
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Text("Music"),
      ),
    );
  }
}
