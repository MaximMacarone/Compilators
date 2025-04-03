void main() {
  RegExp regExp = RegExp(r'waz{3,5}up');

  List<String> input = [
    "wazzzzzup",
    "wazzzup",
    "wazup",
  ];

  for (String str in input) {
    if (regExp.hasMatch(str)) {
      print('Совпадение найдено');
    } else {
      print('Совпадение не найдено');
    }
  }
}
