// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupEntityAdapter extends TypeAdapter<GroupEntity> {
  @override
  final int typeId = 0;

  @override
  GroupEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupEntity(
      name: fields[0] as String,
      color: fields[1] as String,
      createAt: fields[2] as String,
      lastUpdate: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.createAt)
      ..writeByte(3)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
