void main() {
  RegExp regExp = RegExp(r'\d\.\s+abc');

  List<String> input = [
    "1.  abc",
    "2.    abc",
    "3.       abc",
    "4.abc",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
