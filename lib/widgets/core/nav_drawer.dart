import 'package:comp4521_gp4_accelyst/screens/home/home.dart';
import 'package:comp4521_gp4_accelyst/screens/mnemonics/mnemonics.dart';
import 'package:comp4521_gp4_accelyst/screens/music/music.dart';
import 'package:comp4521_gp4_accelyst/screens/settings/settings.dart';
import 'package:comp4521_gp4_accelyst/screens/timer/timer.dart';
import 'package:comp4521_gp4_accelyst/screens/todo/todo.dart';
import 'package:comp4521_gp4_accelyst/utils/animations/fade_route_transition.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 175,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: const Text(
                    "Placeholder header",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMenuItem(
                      context,
                      title: "Home",
                      icon: Icons.home,
                      widget: const Home(),
                    ),
                    _buildMenuItem(
                      context,
                      title: "Mnemonics",
                      icon: Icons.library_books,
                      widget: const Mnemonics(),
                    ),
                    _buildMenuItem(
                      context,
                      title: "To-do",
                      icon: Icons.format_list_bulleted,
                      widget: const Todo(),
                    ),
                    _buildMenuItem(
                      context,
                      title: "Timer",
                      icon: Icons.timer,
                      widget: const Timer(),
                    ),
                    _buildMenuItem(
                      context,
                      title: "Music",
                      icon: Icons.library_music,
                      widget: const Music(),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.white30,
              ),
              _buildMenuItem(
                context,
                title: "Settings",
                icon: Icons.settings,
                widget: const Settings(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

ListTile _buildMenuItem(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Widget widget,
}) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    leading: Icon(icon),
    iconColor: Colors.white,
    onTap: () {
      Navigator.pop(context); // Close drawer
      Navigator.pushReplacement(context, FadeRoute(widget: widget));
    },
  );
}
