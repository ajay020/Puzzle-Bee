import 'package:hive/hive.dart';

abstract class PuzzleContent extends HiveObject {
  final String question;

  PuzzleContent({required this.question});
}
