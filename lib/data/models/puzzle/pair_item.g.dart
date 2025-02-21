// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PairItemAdapter extends TypeAdapter<PairItem> {
  @override
  final int typeId = 4;

  @override
  PairItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PairItem(
      id: fields[0] as String,
      leftItem: fields[1] as String,
      rightItem: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PairItem obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.leftItem)
      ..writeByte(2)
      ..write(obj.rightItem);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PairItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
