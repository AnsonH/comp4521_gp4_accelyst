/// Convert time (in seconds) into "HH:MM:SS" format.
String constructTime(int seconds) {
  String hour = (seconds ~/ 3600).toString().padLeft(2, '0');
  String minute = (seconds % 3600 ~/ 60).toString().padLeft(2, '0');
  String second = (seconds % 60).toString().padLeft(2, '0');

  return "$hour:$minute:$second";
}
