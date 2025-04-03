void main() {
  RegExp regExp = RegExp(r'\d+ file(s)? found\?');

  List<String> input = [
    "1 file found?",
    "2 files found?",
    "24 files found?",
    "No files found.",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
