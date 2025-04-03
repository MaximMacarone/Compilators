void main() {
  RegExp regExp = RegExp(r'^([A-Za-z]{3} (\d{4}))$');

  List<String> input = [
    "Jan 1987",
    "May 1969",
    "Aug 2011",
  ];

  for (String str in input) {
    var match = regExp.firstMatch(str)!;
    print('${match.group(1)} ${match.group(2)}');
  }
}
