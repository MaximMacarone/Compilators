void main() {
  RegExp regExp = RegExp(r'[A-Z][a-z]{2}');

  List<String> input = [
    "Ana",
    "Bob",
    "Cpc",
    "aax",
    "bby",
    "ccz",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
