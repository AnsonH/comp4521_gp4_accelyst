import 'package:comp4521_gp4_accelyst/models/app_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// `setPageIndex` method from `_MyAppState`.
    var setPageIndex = Provider.of<void Function(int)>(context);

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
                  children: appScreens
                      .map((screen) => ListTile(
                            title: Text(
                              screen.drawerTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            leading: Icon(screen.drawerIcon),
                            iconColor: Colors.white,
                            onTap: () {
                              Navigator.pop(context); // Close drawer
                              int index =
                                  getAppScreenPageIndex(screen.drawerTitle);
                              setPageIndex(index);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
