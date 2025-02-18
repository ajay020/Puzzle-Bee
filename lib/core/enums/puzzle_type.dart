enum PuzzleType {
  multipleChoice,
  matchingPairs,
  fillInTheBlank,
  trueFalse,
}

String puzzleTypeToString(PuzzleType type) {
  return type.name;
}

PuzzleType puzzleTypeFromString(String type) {
  return PuzzleType.values.byName(type);
}
