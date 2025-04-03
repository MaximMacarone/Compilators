void main() {
  RegExp regExp = RegExp(r'abc.*');

  List<String> input = [
    "abcdefg",
    "abcde",
    "abc",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
