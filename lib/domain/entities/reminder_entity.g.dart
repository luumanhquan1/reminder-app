// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderEntityAdapter extends TypeAdapter<ReminderEntity> {
  @override
  final int typeId = 1;

  @override
  ReminderEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReminderEntity(
      title: fields[0] as String,
      note: fields[1] as String,
      details: fields[2] as DetailsEntity,
      list: fields[3] as String,
      createAt: fields[4] as String,
      lastUpdate: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ReminderEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.details)
      ..writeByte(3)
      ..write(obj.list)
      ..writeByte(4)
      ..write(obj.createAt)
      ..writeByte(5)
      ..write(obj.lastUpdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
