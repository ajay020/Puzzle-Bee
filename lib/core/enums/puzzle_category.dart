enum PuzzleCategory { english, math }

// Separate enums for subcategories
enum EnglishSubCategory {
  vocabulary,
  spelling,
  synonyms,
  antonyms,
  grammar,
  reading,
  homophones,
}

enum MathSubCategory {
  arithmetic,
  equations,
  fractions,
  algebra,
  geometry,
  multiplication,
  time,
}

// Convert category enum to string
String categoryToString(PuzzleCategory category) => category.name;
PuzzleCategory categoryFromString(String category) =>
    PuzzleCategory.values.byName(category);

// Convert subcategory enums to string
String englishSubToString(EnglishSubCategory sub) => sub.name;
String mathSubToString(MathSubCategory sub) => sub.name;

// Convert string to enum
EnglishSubCategory englishSubFromString(String sub) =>
    EnglishSubCategory.values.byName(sub);
MathSubCategory mathSubFromString(String sub) =>
    MathSubCategory.values.byName(sub);
