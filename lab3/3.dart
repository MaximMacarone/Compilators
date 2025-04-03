void main() {
  RegExp regExp = RegExp(r'[cfm]an');

  List<String> input = [
    "can",
    "man",
    "fan",
    "dan",
    "ran",
    "pan",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
