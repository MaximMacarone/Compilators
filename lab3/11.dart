void main() {
  RegExp regExp = RegExp(r'^(.*)\.pdf$');

  List<String> input = [
    "file_record_transcript.pdf",
    "file_07241999.pdf",
    "testfile_fake.pdf.tmp"
  ];

  for (String str in input) {
    final match = regExp.firstMatch(str);
    if (match != null) {
      print('${match.group(1)}');
    } else {
      print('Совпадение не найдено');
    }
  }
}
