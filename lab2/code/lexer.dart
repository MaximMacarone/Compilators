class Token {
  final String type;
  final String value;

  Token(this.type, this.value);

  @override
  String toString() => 'Token(type: $type, value: $value)';
}

class Lexer {
  final String input;
  int position = 0;

  Lexer(this.input);

  bool get isAtEnd => position >= input.length;
  String get currentChar => isAtEnd ? '' : input[position];

  void advance() => position++;

  void skipWhitespace() {
    while (!isAtEnd && currentChar.trim().isEmpty) {
      advance();
    }
  }

  Token nextToken() {
    skipWhitespace();
    if (isAtEnd) return Token('EOF', '');

    if (currentChar == '{') {
      advance();
      return Token('BEGIN', '{');
    }

    if (currentChar == '}') {
      advance();
      return Token('END', '}');
    }

    if (currentChar == ':') {
      advance();
      return Token('COLON', ':');
    }

    if (currentChar == ',') {
      advance();
      return Token('COMMA', ',');
    }

    if (_isLetter(currentChar)) {
      String word = readString();
      if (word == 'country' || word == 'city' || word == 'dist') {
        return Token('KEYWORD', word);
      }
      return Token('STRING', word);
    }

    if (_isDigit(currentChar)) {
      return Token('AREA', readNumber());
    }

    return Token('ERR', 'Unexpected character: $currentChar');
  }

  bool _isLetter(String char) => RegExp(r'[a-zA-Z]').hasMatch(char);
  bool _isDigit(String char) => RegExp(r'\d').hasMatch(char);

  String readString() {
    final buffer = StringBuffer();
    while (!isAtEnd && _isLetter(currentChar)) {
      buffer.write(currentChar);
      advance();
    }
    return buffer.toString();
  }

  String readNumber() {
    final buffer = StringBuffer();
    while (!isAtEnd && _isDigit(currentChar)) {
      buffer.write(currentChar);
      advance();
    }
    return buffer.toString();
  }
}
