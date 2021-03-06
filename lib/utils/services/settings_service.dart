/// This file stores code for getting and storing key-value pair data from the local storage.
/// It can be used to save user preferences in the app settings.

import 'package:shared_preferences/shared_preferences.dart';

/// This class consists of a get-set pair of functions for each individual setting
/// List of settings:
/// - Timer minimum time
/// - Timer maximum time
/// - Timer default time
/// - To-do deadline notification time
class SettingsService {
  // Timer

  // Timer min time, default = 10 minutes
  static Future<int> getTimerMinTime() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('timer-min-time') ?? 10;
  }

  static Future<void> setTimerMinTime(int minutes) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('timer-min-time', minutes);
    await _prefs.reload();
  }

  // Timer max time, default = 2 hours / 120 minutes
  static Future<int> getTimerMaxTime() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('timer-max-time') ?? 120;
  }

  static Future<void> setTimerMaxTime(int minutes) async {
    final _prefs = await SharedPreferences.getInstance();
    if (minutes > 180) minutes = 180;
    await _prefs.setInt('timer-max-time', minutes);
    await _prefs.reload();
  }

  // Timer default time, default = 25 minutes
  static Future<int> getTimerDefaultTime() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('timer-default-time') ?? 25;
  }

  static Future<void> setTimerDefaultTime(int minutes) async {
    final _prefs = await SharedPreferences.getInstance();
    final min = await getTimerMinTime();
    final max = await getTimerMaxTime();
    if (minutes < min || minutes > max) {
      minutes = (min + max) ~/ 2;
    }
    await _prefs.setInt('timer-default-time', minutes);
    await _prefs.reload();
  }

  static Future<bool> getTimerFocusMode() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('timer-focus-mode') ?? false;
  }

  static Future<void> setTimerFocusMode(bool value) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('timer-focus-mode', value);
    await _prefs.reload();
  }

  // To-do

  // To-do deadline notification hours before deadline, default = 15 hours
  static Future<int> getTodoNotiTime() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt('todo-noti-time') ?? 15;
  }

  static Future<void> setTodoNotiTime(int hours) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt('todo-noti-time', hours);
    await _prefs.reload();
  }
}
