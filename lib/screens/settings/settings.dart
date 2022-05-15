import 'package:comp4521_gp4_accelyst/utils/services/settings_service.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/nav_drawer.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/slider_with_label.dart';
import 'package:comp4521_gp4_accelyst/widgets/core/switch_with_label.dart';
import 'package:comp4521_gp4_accelyst/widgets/settings/settings_section.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final Future<int> _timerDefaultTime = SettingsService.getTimerDefaultTime();
  final Future<bool> _timerFocusMode = SettingsService.getTimerFocusMode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      drawer: const NavDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    "All settings are auto-saved and will be applied on restart of the app.",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SettingsSection(
              title: "Timer",
              children: [
                FutureBuilder<int>(
                  future: _timerDefaultTime,
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    // Checks if the future value has arrived
                    if (snapshot.hasData) {
                      return SliderWithLabel(
                        label: "Default duration (mins)",
                        initialValue: snapshot.data!,
                        min: 10,
                        max: 120,
                        onChangeEnd: (int mins) {
                          SettingsService.setTimerDefaultTime(mins);
                        },
                        icon: Icons.timer_outlined,
                      );
                    }
                    return Container();
                  },
                ),
                FutureBuilder<bool>(
                  future: _timerFocusMode,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return SwitchWithLabel(
                        label: 'Enable Focus Mode',
                        initialValue: snapshot.data!,
                        onChanged: (bool val) {
                          SettingsService.setTimerFocusMode(val);
                        },
                        icon: Icons.gps_fixed,
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
