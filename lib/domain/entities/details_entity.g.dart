// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailsEntityAdapter extends TypeAdapter<DetailsEntity> {
  @override
  final int typeId = 2;

  @override
  DetailsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailsEntity(
      date: fields[0] as String,
      time: fields[1] as String,
      priority: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailsEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
