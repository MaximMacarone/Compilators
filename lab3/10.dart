void main() {
  RegExp regExp = RegExp(r'^Mission: successful$');

  List<String> input = [
    "Mission: successful",
    "Last Mission: unsuccessful",
    "Next Mission: successful upon capture of target"
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
