void main() {
  RegExp regExp = RegExp(r'^(\d+)x(\d+)$');

  List<String> input = [
    "1280x720",
    "1920x1080",
    "1024x768",
  ];

  for (String str in input) {
    var match = regExp.firstMatch(str)!;
    print('${match.group(1)} ${match.group(2)}');
  }
}
