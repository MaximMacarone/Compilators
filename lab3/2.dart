void main() {
  RegExp regExp = RegExp(r'.+\.');

  List<String> input = ["cat.", "896.", "?=+.", "abc1",];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
