void main() {
  RegExp regExp = RegExp(r'\d+');

  List<String> input = [
    "abc123xyz",
    "defint \"123\"",
    "var g = 123",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
