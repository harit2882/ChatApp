// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 0;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      senderId: fields[0] as String,
      receiverId: fields[1] as String,
      text: fields[2] as String,
      type: (fields[3] as String).toEnum(),
      timeSent:DateTime.parse( fields[4].toString()),
      columnId: fields[5] as String,
      isSeen: fields[6] as bool,
      msgStatus: (fields[7] as String).toEnumStatus(),
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.senderId)
      ..writeByte(1)
      ..write(obj.receiverId)
      ..writeByte(2)
      ..write(obj.text)
      ..writeByte(3)
      ..write(obj.type.type.toString())
      ..writeByte(4)
      ..write(obj.timeSent.toString())
      ..writeByte(5)
      ..write(obj.columnId)
      ..writeByte(6)
      ..write(obj.isSeen)
      ..writeByte(7)
      ..write(obj.msgStatus.type.toString());
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
