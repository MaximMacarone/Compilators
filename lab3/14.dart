void main() {
  RegExp regExp = RegExp(r'I love (cats|dogs)$');

  List<String> input = [
    "I love cats",
    "I love dogs",
    "I love logs",
    "I love cogs",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
