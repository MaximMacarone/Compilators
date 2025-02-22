import 'dart:io';

enum States {
  InitView,
  North,
  West,
  East,
  South,
  Nendl,
  Wendl,
  Eendl,
  Sendl,
  Err,
  End,
}

void main() {
  var currentState = States.InitView;

  final transitions = {
    States.InitView: {'n': () => States.Nendl, 's': () => States.Sendl, 'e': () => States.Eendl, 'w': () => States.Wendl, '\n': () => States.Err, 'f': () => States.Err,'l': () => States.Err,'r': () => States.Err,'.': () => States.End},
    States.North: {'f': moveNorth, 'l': () => States.Wendl, 'r': () => States.Eendl, '\n': () => States.North, '.': () => States.End,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.South: {'f': moveSouth, 'l': () => States.Eendl, 'r': () => States.Wendl, '\n': () => States.South, '.': () => States.End,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.East: {'f': moveEast, 'l': () => States.Nendl, 'r': () => States.Sendl, '\n': () => States.East, '.': () => States.End,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.West: {'f': moveWest, 'l': () => States.Sendl, 'r': () => States.Nendl, '\n': () => States.West, '.': () => States.End,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.Nendl: {'\n': () => States.North, '.': () => States.End,'f': () => States.Err, 'l': () => States.Err, 'r': () => States.Err,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.Wendl: {'\n': () => States.West, '.': () => States.End,'f': () => States.Err, 'l': () => States.Err, 'r': () => States.Err,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.Eendl: {'\n': () => States.East, '.': () => States.End,'f': () => States.Err, 'l': () => States.Err, 'r': () => States.Err,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.Sendl: {'\n': () => States.South, '.': () => States.End,'f': () => States.Err, 'l': () => States.Err, 'r': () => States.Err,'n': () => States.Err,'s': () => States.Err,'w': () => States.Err,'e': () => States.Err},
    States.End: {},
    States.Err: {}
  };

  final sourceFile = File('${Directory.current.path}/source.txt');
  final sourceFileSymbols = sourceFile.readAsStringSync();
  
  for (final symbolCode in sourceFileSymbols.runes) {
    final symbol = String.fromCharCode(symbolCode);
    if (!transitions[currentState]!.containsKey(symbol)) {
      currentState = States.Err;
      break;
    }
    currentState = transitions[currentState]![symbol]!();
  }

  if(currentState != States.End) {
    currentState = States.Err;
  }

  print('Final State: $currentState');
}

States moveNorth() {
  print("move north");
  return States.Nendl;
}

States moveSouth() {
  print("move south");
    return States.Sendl;
}

States moveEast() {
  print("move east");
  return States.Eendl;
}

States moveWest() {
  print("move west");
  return States.Wendl;
}