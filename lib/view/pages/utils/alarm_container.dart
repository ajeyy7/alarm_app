import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../../model/alarm_class.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onDelete;

  const AlarmTile(
      {required this.alarm, required this.onDelete}); // Add this constructor

  @override
  Widget build(BuildContext context) {


    ///alrm Tile

    return ListTile(
      title: Container(
        height: 90,
        width: 360,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.blueGrey.shade200),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('hh:mm a').format(DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  alarm.time.hour,
                  alarm.time.minute,
                )),
                style: TextStyle(fontSize: 35, color: Colors.grey.shade900),
              ),
              SizedBox(width: 10),
              Row(
                children: [
                  ///switch
                  Switch(
                    value: alarm.isEnabled,
                    onChanged: (value) {
                      alarm.isEnabled = value;
                      Hive.box<Alarm>('alarms').putAt(alarm.key, alarm);
                    },
                  ),
                  ///delete button
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red.shade300,
                      size: 40,
                    ),
                    onPressed: onDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
