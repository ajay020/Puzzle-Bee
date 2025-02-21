// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'puzzle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PuzzleAdapter extends TypeAdapter<Puzzle> {
  @override
  final int typeId = 5;

  @override
  Puzzle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Puzzle(
      id: fields[0] as String,
      title: fields[1] as String,
      category: fields[2] as PuzzleCategory,
      subCategory: fields[3] as dynamic,
      type: fields[4] as PuzzleType,
      content: fields[5] as PuzzleContent,
    );
  }

  @override
  void write(BinaryWriter writer, Puzzle obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.subCategory)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PuzzleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
