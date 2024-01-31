import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Alarm {
  late int key;

  late TimeOfDay time;
  late bool isEnabled;

  Alarm({required this.key, required this.time, this.isEnabled = true});
}

@HiveType(typeId: 0)
class AlarmAdapter extends TypeAdapter<Alarm> {
  @override
  final int typeId = 0;

  @override
  Alarm read(BinaryReader reader) {
    return Alarm(
      key: reader.read(),
      time: TimeOfDay(
        hour: reader.read(),
        minute: reader.read(),
      ),
      isEnabled: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, Alarm obj) {
    writer.write(obj.key);
    writer.write(obj.time.hour);
    writer.write(obj.time.minute);
    writer.write(obj.isEnabled);
  }
}
