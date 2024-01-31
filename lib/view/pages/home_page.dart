import 'package:alarm_app/view/pages/utils/alarm_container.dart';
import 'package:alarm_app/view/pages/utils/whether_container.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/alarm_class.dart';
import '../../model/local_notifications.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Box _alarmBox;

  @override
  void initState() {
    super.initState();
    _alarmBox = Hive.box<Alarm>('alarms');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      body: Column(
        children: [
          const Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              //   height: MediaQuery.of(context).size.width,
              child:
                  Align(alignment: Alignment.center, child: WeatherContainer()),
            ),
          ),
          Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(36),
                        topLeft: Radius.circular(36),
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: _alarmBox.length,
                      itemBuilder: (context, index) {
                        Alarm alarm = _alarmBox.getAt(index)!;
                        return AlarmTile(
                            alarm: alarm, onDelete: () => _deleteAlarm(index));
                      },
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ElevatedButton(
                            onPressed: _addAlarm,
                            child: const Text(
                              "Set Alarm",
                              style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700),
                            )),
                      ))
                ],
              ))
        ],
      ),
    );
  }

  void _addAlarm() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      Alarm newAlarm = Alarm(
        key: DateTime.now().millisecondsSinceEpoch,
        time: selectedTime,
      );
      _alarmBox.add(newAlarm);
      _scheduleNotification(newAlarm);
      setState(() {});
    }
  }
  void _scheduleNotification(Alarm alarm)async {
    // Create a DateTime object for the user-selected time
    DateTime triggerDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      alarm.time.hour,
      alarm.time.minute,
    );
    // Check if the trigger time is in the future
    if (triggerDateTime.isAfter(DateTime.now())) {
      // Calculate the time difference
      Duration timeUntilNotification = triggerDateTime.difference(DateTime.now());

      // Schedule the notification
      await Future.delayed(timeUntilNotification, () {
        LocalNoti.showAlarmNotification(
          title: 'Alarm!!',
          body: 'Your Alarm is ringing!!!',
          payload: 'Alarm!!!',
        );
      });
    }


  }

  void _deleteAlarm(int index) {
    _alarmBox.deleteAt(index);
    setState(() {});
  }
}
