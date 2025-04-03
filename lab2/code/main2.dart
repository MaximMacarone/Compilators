import 'dart:io';

import 'lexer.dart';

class ParseTreeNode {
  final String type;
  final String? value;
  final List<ParseTreeNode> children = [];

  ParseTreeNode(this.type, [this.value]);

  void addChild(ParseTreeNode node) {
    children.add(node);
  }

  @override
  String toString() => _toStringWithIndent(0);

  String _toStringWithIndent(int indent) {
    final indentStr = '  ' * indent;
    var result = '$indentStr$type${value != null ? '("$value")' : ''}';
    for (final child in children) {
      result += '\n${child._toStringWithIndent(indent + 1)}';
    }
    return result;
  }
}

class ParseTreeBuilder {
  final List<Token> tokens;
  int _pos = 0;

  ParseTreeBuilder(this.tokens);

  Token get _currentToken =>
      _pos < tokens.length ? tokens[_pos] : Token('EOF', '');

  ParseTreeNode build() {
    return _parseProgram();
  }

  ParseTreeNode _parseProgram() {
    final node = ParseTreeNode('Program');
    node.addChild(_parseCountry());
    return node;
  }

  ParseTreeNode _parseCountry() {
    final node = ParseTreeNode('Country');

    // "country"
    _expect('KEYWORD', 'country');
    node.addChild(ParseTreeNode('TOKEN', 'country'));
    _pos++;

    // Name
    _expect('STRING');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    // ":"
    _expect('COLON');
    node.addChild(ParseTreeNode('TOKEN', ':'));
    _pos++;

    // Area
    _expect('AREA');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    // "{"
    _expect('BEGIN');
    node.addChild(ParseTreeNode('TOKEN', '{'));
    _pos++;

    // CityList
    final cityListNode = ParseTreeNode('CityList');
    cityListNode.addChild(_parseCity());
    node.addChild(cityListNode);

    // "}"
    _expect('END');
    node.addChild(ParseTreeNode('TOKEN', '}'));
    _pos++;

    return node;
  }

  ParseTreeNode _parseCity() {
    final node = ParseTreeNode('City');

    // "city"
    _expect('KEYWORD', 'city');
    node.addChild(ParseTreeNode('TOKEN', 'city'));
    _pos++;

    // Name
    _expect('STRING');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    // ":"
    _expect('COLON');
    node.addChild(ParseTreeNode('TOKEN', ':'));
    _pos++;

    // Area
    _expect('AREA');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    // "{"
    _expect('BEGIN');
    node.addChild(ParseTreeNode('TOKEN', '{'));
    _pos++;

    // DistrictList
    final districtListNode = ParseTreeNode('DistrictList');
    districtListNode.addChild(_parseDistrict());
    node.addChild(districtListNode);

    // "}"
    _expect('END');
    node.addChild(ParseTreeNode('TOKEN', '}'));
    _pos++;

    return node;
  }

  ParseTreeNode _parseDistrict() {
    final node = ParseTreeNode('District');

    // "dist"
    _expect('KEYWORD', 'dist');
    node.addChild(ParseTreeNode('TOKEN', 'dist'));
    _pos++;

    // Name
    _expect('STRING');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    // ":"
    _expect('COLON');
    node.addChild(ParseTreeNode('TOKEN', ':'));
    _pos++;

    // Area
    _expect('AREA');
    node.addChild(ParseTreeNode('TOKEN', _currentToken.value));
    _pos++;

    return node;
  }

  void _expect(String type, [String? value]) {
    if (_currentToken.type != type ||
        (value != null && _currentToken.value != value)) {
      throw Exception(
          'Expected $type${value != null ? ' "$value"' : ''}, but got ${_currentToken.type} "${_currentToken.value}"');
    }
  }
}

void main() {
  String input = File("main.bbr").readAsStringSync();
  Lexer lexer = Lexer(input);
  List<Token> tokens = [];
  Token token;
  while ((token = lexer.nextToken()).type != 'EOF') {
    tokens.add(token);
    // print(token);
  }

  final builder = ParseTreeBuilder(tokens);
  final parseTree = builder.build();
  print(parseTree);
}
