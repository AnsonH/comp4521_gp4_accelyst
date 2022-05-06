import 'package:comp4521_gp4_accelyst/utils/services/settings_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Future<int> _minTime = SettingsService.getTimerMinTime();

  @override
  void initState() {
    super.initState();
    _minTime = SettingsService.getTimerMinTime();
  }

  void _retry() {
    setState(() {
      _minTime = SettingsService.getTimerMinTime();
    });
  }

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
                    return Text("");
                  }
                }),
            ElevatedButton(
                onPressed: () async {
                  await SettingsService.setTimerDefaultTime(40);
                  await SettingsService.setTimerMinTime(20);
                  await SettingsService.setTimerMaxTime(170);
                  print(await SettingsService.getTimerMinTime());
                  print(await SettingsService.getTimerMaxTime());
                },
                child: Text("Change Timer Settings")),
          ],
        ),
      ),
    );
  }
}
