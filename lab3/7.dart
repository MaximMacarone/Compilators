void main() {
  RegExp regExp = RegExp(r'a+b*c+');

  List<String> input = [
    "aaaabcc",
    "aabbbbc",
    "aacc",
    "a",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
