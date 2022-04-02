// ignore: constant_identifier_names
enum TimeFormat { HH_mm_ss, mm_ss }

/// Format time (in seconds) into a "HH:mm:ss" or "mm:ss" string.
String constructTime(int seconds, {TimeFormat timeFormat = TimeFormat.mm_ss}) {
  final duration = Duration(seconds: seconds);

  String hour = duration.inHours.toString().padLeft(2, "0");
  String second = (duration.inSeconds % 60).toString().padLeft(2, '0');

  switch (timeFormat) {
    case TimeFormat.HH_mm_ss:
      return "$hour:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:$second";
    case TimeFormat.mm_ss:
      return '${(duration.inMinutes).toString().padLeft(2, '0')}:$second';
  }
}
