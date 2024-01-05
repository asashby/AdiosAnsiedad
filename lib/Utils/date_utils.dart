
extension DateTimeFormat on Duration{

  String get convertHHMM{
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(inSeconds.remainder(60));
    return twoDigits(inHours) == "00" ? "$twoDigitMinutes:$twoDigitSeconds" : "${twoDigits(inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

}
