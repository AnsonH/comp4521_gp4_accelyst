import 'package:comp4521_gp4_accelyst/utils/services/settings_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Future<int> _minTime = SettingsService.getTimerMinTime();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const NavDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width * 0.4,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Settings"),
            FutureBuilder<int>(
              future: _minTime,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data}');
                } else {
                  return const Text("");
                }
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await SettingsService.setTimerDefaultTime(40);
                await SettingsService.setTimerMinTime(1);
                await SettingsService.setTimerMaxTime(180);
                print(await SettingsService.getTimerMinTime());
                print(await SettingsService.getTimerMaxTime());
              },
              child: const Text("Change Timer Settings"),
            ),
            ElevatedButton(
              onPressed: () async {
                await SettingsService.setTimerDefaultTime(25);
                await SettingsService.setTimerMinTime(10);
                await SettingsService.setTimerMaxTime(120);
                print(await SettingsService.getTimerMinTime());
                print(await SettingsService.getTimerMaxTime());
              },
              child: const Text("Reset Timer Settings"),
            ),
          ],
        ),
      ),
    );
  }
}
