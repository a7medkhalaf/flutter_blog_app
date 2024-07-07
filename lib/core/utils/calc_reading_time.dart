int calcReadingTime(String content) {
  return ((content.split(RegExp(r'\s+')).length / 225)).ceil();
}
