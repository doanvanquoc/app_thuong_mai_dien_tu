// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NotificationCKCAdapter extends TypeAdapter<NotificationCKC> {
  @override
  final int typeId = 1;

  @override
  NotificationCKC read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationCKC(
      iconNumb: fields[0] as int,
      notiDate: fields[1] as DateTime,
      title: fields[2] as String,
      content: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationCKC obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.iconNumb)
      ..writeByte(1)
      ..write(obj.notiDate)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationCKCAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
