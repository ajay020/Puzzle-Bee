import 'package:flutter/material.dart';
import 'package:puzzle_bee/core/enums/puzzle_category.dart';

import '../../../core/enums/puzzle_type.dart';
import 'fill_blank_content.dart';
import 'match_pairs_content.dart';
import 'multiple_choice_content.dart';
import 'puzzle_content.dart';
import 'true_false_content.dart';

class Puzzle {
  final String id;
  final String title;
  final PuzzleCategory category;
  final dynamic subCategory; // Can be EnglishSubCategory or MathSubCategory
  final PuzzleType type;
  final PuzzleContent content;

  Puzzle({
    required this.id,
    required this.title,
    required this.category,
    required this.subCategory,
    required this.type,
    required this.content,
  });

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    PuzzleCategory category = categoryFromString(json['category']);

    dynamic subCategory;

    if (category == PuzzleCategory.english) {
      subCategory = englishSubFromString(json['subCategory']);
    } else if (category == PuzzleCategory.math) {
      subCategory = mathSubFromString(json['subCategory']);
    }

    PuzzleType type =
        puzzleTypeFromString(json['type']); // Convert string to enum
    PuzzleContent content;

    switch (type) {
      case PuzzleType.multipleChoice:
        content = MultipleChoiceContent.fromJson(json['content']);
        break;
      case PuzzleType.trueFalse:
        content = TrueFalseContent.fromJson(json['content']);
        break;
      case PuzzleType.fillInTheBlank:
        content = FillBlankContent.fromJson(json['content']);
        break;
      case PuzzleType.matchingPairs:
        content = MatchPairsContent.fromJson(json['content']);
        break;
      default:
        debugPrint('Unknown puzzle type: ${json['content']['type']}');
        throw Exception('Unknown puzzle type');
    }

    return Puzzle(
      id: json['id'],
      title: json['title'],
      category: category,
      subCategory: subCategory,
      type: type,
      content: content,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': categoryToString(category),
      'subCategory': _getSubCategoryString(),
      'type': puzzleTypeToString(type),
      'content': _getContentJson(),
    };
  }

  String _getSubCategoryString() {
    if (category == PuzzleCategory.english) {
      return englishSubToString(subCategory as EnglishSubCategory);
    } else if (category == PuzzleCategory.math) {
      return mathSubToString(subCategory as MathSubCategory);
    }
    throw Exception('Unknown category');
  }

  Map<String, dynamic> _getContentJson() {
    switch (content) {
      case MultipleChoiceContent():
        return (content as MultipleChoiceContent).toJson();
      case TrueFalseContent():
        return (content as TrueFalseContent).toJson();
      case FillBlankContent():
        return (content as FillBlankContent).toJson();
      case MatchPairsContent():
        return (content as MatchPairsContent).toJson();
      default:
        throw Exception('Unknown puzzle content type');
    }
  }
}
