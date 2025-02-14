enum PuzzleType {
  multipleChoice,
  matchingPairs,
  fillInTheBlank,
  trueFalse
  // Add more puzzle types in the future!
}

String puzzleTypeToString(PuzzleType type) {
  return type.name;
}

PuzzleType puzzleTypeFromString(String type) {
  return PuzzleType.values.byName(type);
}
