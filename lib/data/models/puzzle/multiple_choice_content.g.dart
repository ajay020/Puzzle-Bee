// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multiple_choice_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultipleChoiceContentAdapter extends TypeAdapter<MultipleChoiceContent> {
  @override
  final int typeId = 2;

  @override
  MultipleChoiceContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultipleChoiceContent(
      question: fields[0] as String,
      options: (fields[1] as List).cast<String>(),
      correctOptionIndex: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MultipleChoiceContent obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.correctOptionIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultipleChoiceContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
