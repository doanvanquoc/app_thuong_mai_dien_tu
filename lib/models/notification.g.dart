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
      notificationID: fields[0] as int,
      userID: fields[1] as int,
      notiDate: fields[2] ?? '' as String,
      title: fields[3] ?? '' as String,
      content: fields[4] ?? '' as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationCKC obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.notificationID)
      ..writeByte(1)
      ..write(obj.userID)
      ..writeByte(2)
      ..write(obj.notiDate)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
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
