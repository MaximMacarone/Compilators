void main() {
  RegExp regExp = RegExp(r'[^b]og');

  List<String> input = [
    "hog",
    "dog",
    "bog",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
