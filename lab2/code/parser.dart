import 'lexer.dart';

class Node {
  final String type;
  String name; // Изменяем value на name
  String area; // Добавляем отдельное поле для площади
  final List<Node> children = [];

  Node(this.type, this.name, [this.area = '']);

  void addChild(Node child) {
    children.add(child);
  }

  int getTotalArea() {
    if (children.isEmpty) {
      return int.tryParse(area) ?? 0;
    }
    return children.fold(0, (sum, child) => sum + child.getTotalArea());
  }

  @override
  String toString() {
    return _toStringWithIndent(0);
  }

  String _toStringWithIndent(int indent) {
    final indentStr = '  ' * indent;
    var result = '$indentStr$type($name${area.isNotEmpty ? ': $area' : ''})';
    for (final child in children) {
      result += '\n${child._toStringWithIndent(indent + 1)}';
    }
    return result;
  }
}

class Parser {
  final List<Token> tokens;
  int position = 0;

  Parser(this.tokens);

  bool get isAtEnd => position >= tokens.length;
  Token get currentToken => isAtEnd ? Token('EOF', '') : tokens[position];

  void advance() => position++;

  Node parse() {
    try {
      return parseCountry();
    } catch (e) {
      print('Ошибка парсинга: $e');
      return Node('ERROR', 'Parsing failed');
    }
  }

  Node parseCountry() {
    if (currentToken.type != 'KEYWORD' || currentToken.value != 'country') {
      throw Exception('Ожидалось ключевое слово "country"');
    }
    advance();

    if (currentToken.type != 'STRING') {
      throw Exception('Ожидалось имя страны');
    }
    String countryName = currentToken.value;
    advance();

    if (currentToken.type != 'COLON') {
      throw Exception('Ожидался символ ":"');
    }
    advance();

    if (currentToken.type != 'AREA') {
      throw Exception('Ожидалась числовая область');
    }
    String countryArea = currentToken.value;
    advance();

    if (currentToken.type != 'BEGIN') {
      throw Exception('Ожидался символ "{"');
    }
    advance();

    Node countryNode = Node('COUNTRY', countryName, countryArea);

    // Обрабатываем список городов
    bool firstCity = true;
    while (currentToken.type != 'END' && currentToken.type != 'EOF') {
      if (!firstCity) {
        if (currentToken.type == 'COMMA') {
          advance();
        } else {
          throw Exception('Ожидалась запятая между городами');
        }
      }

      countryNode.addChild(parseCity());
      firstCity = false;
    }

    if (currentToken.type != 'END') {
      throw Exception('Ожидался символ "}"');
    }
    advance();

    int actualArea = countryNode.getTotalArea();
    int expectedArea = int.parse(countryArea);
    if (actualArea != expectedArea) {
      throw Exception(
          'Ошибка: Сумма площадей городов ($actualArea) не совпадает с указанной ($expectedArea)');
    }
    return countryNode;
  }

  Node parseCity() {
    if (currentToken.type != 'KEYWORD' || currentToken.value != 'city') {
      throw Exception('Ожидалось ключевое слово "city"');
    }
    advance();

    if (currentToken.type != 'STRING') {
      throw Exception('Ожидалось имя города');
    }
    String cityName = currentToken.value;
    advance();

    if (currentToken.type != 'COLON') {
      throw Exception('Ожидался символ ":"');
    }
    advance();

    if (currentToken.type != 'AREA') {
      throw Exception('Ожидалась числовая область');
    }
    String cityArea = currentToken.value;
    advance();

    if (currentToken.type != 'BEGIN') {
      throw Exception('Ожидался символ "{"');
    }
    advance();

    Node cityNode = Node('CITY', cityName, cityArea);

    // Обрабатываем список районов
    bool firstDistrict = true;
    while (currentToken.type != 'END' && currentToken.type != 'EOF') {
      if (!firstDistrict) {
        if (currentToken.type == 'COMMA') {
          advance();
        } else {
          throw Exception('Ожидалась запятая между районами');
        }
      }

      cityNode.addChild(parseDistrict());
      firstDistrict = false;
    }

    if (currentToken.type != 'END') {
      throw Exception('Ожидался символ "}"');
    }
    advance();

    int actualArea = cityNode.getTotalArea();
    int expectedArea = int.parse(cityArea);
    if (actualArea != expectedArea) {
      throw Exception(
          'Ошибка: Сумма площадей районов ($actualArea) не совпадает с указанной ($expectedArea) для города $cityName');
    }
    return cityNode;
  }

  Node parseDistrict() {
    if (currentToken.type != 'KEYWORD' || currentToken.value != 'dist') {
      throw Exception('Ожидалось ключевое слово "dist"');
    }
    advance();

    if (currentToken.type != 'STRING') {
      throw Exception('Ожидалось имя района');
    }
    String districtName = currentToken.value;
    advance();

    if (currentToken.type != 'COLON') {
      throw Exception('Ожидался символ ":"');
    }
    advance();

    if (currentToken.type != 'AREA') {
      throw Exception('Ожидалась числовая область');
    }
    String districtArea = currentToken.value;
    advance();

    return Node('DISTRICT', districtName, districtArea);
  }
}
