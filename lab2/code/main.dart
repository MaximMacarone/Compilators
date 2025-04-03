import 'dart:io';

import 'lexer.dart';
import 'parser.dart';

void main() {
  String input = File("lab2/code/main.bbr").readAsStringSync();
  Lexer lexer = Lexer(input);
  List<Token> tokens = [];
  Token token;
  while ((token = lexer.nextToken()).type != 'EOF') {
    tokens.add(token);
    // print(token);
  }

  Parser parser = Parser(tokens);
  Node rootNode = parser.parse();
  print(rootNode);
}
