// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_pairs_content.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MatchPairsContentAdapter extends TypeAdapter<MatchPairsContent> {
  @override
  final int typeId = 3;

  @override
  MatchPairsContent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MatchPairsContent(
      question: fields[0] as String,
      pairs: (fields[1] as List).cast<PairItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, MatchPairsContent obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.pairs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MatchPairsContentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
