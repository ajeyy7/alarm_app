import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/alarm_class.dart';

class AlarmProvider extends ChangeNotifier {
  late Box<Alarm> _alarmBox;

  AlarmProvider() {
    _alarmBox = Hive.box<Alarm>('alarms');
  }

  Box<Alarm> get alarmBox => _alarmBox;

  void addAlarm(Alarm newAlarm) {
    _alarmBox.add(newAlarm);
    notifyListeners();
  }

  void deleteAlarm(int index) {
    _alarmBox.deleteAt(index);
    notifyListeners();
  }
}