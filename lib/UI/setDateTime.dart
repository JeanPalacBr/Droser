import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lease_drones/Models/aviso.dart';

class setDateTime extends StatefulWidget {
  @override
  setDateTimeState createState() => setDateTimeState();
}

class setDateTimeState extends State<setDateTime> {
  DateTime _alarmTime;
  String _alarmTimeString = "00:00";
  Future<List<Aviso>> _alarms;
  bool pressedl = false;
  bool pressedm = false;
  bool pressedmi = false;
  bool pressedj = false;
  bool pressedv = false;
  bool presseds = false;
  bool pressedd = false;
  bool repeat = false;
  String dias = "";

  @override
  void loadAlarms() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _name = new TextEditingController();
    BuildContext contexto = context;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Alarma"),
          backgroundColor: Colors.blue[400],
        ),
        body: Column(children: [
          Row(
            children: [
              Center(
                child: FlatButton(
                  onPressed: () async {
                    var selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      final now = DateTime.now();
                      var selectedDateTime = DateTime(now.year, now.month,
                          now.day, selectedTime.hour, selectedTime.minute);
                      _alarmTime = selectedDateTime;
                      setState(() {
                        _alarmTimeString = selectedTime.toString();
                      });
                    }
                  },
                  child: Text(
                      _alarmTimeString.length > 6
                          ? _alarmTimeString.substring(10, 15)
                          : _alarmTimeString,
                      style: TextStyle(color: Colors.black, fontSize: 50)),
                ),
              ),
            ],
          ),
          FlatButton(
              color: Colors.blue,
              onPressed: () {
                DateTime scheduleAlarmDateTime;

                if (_alarmTime.isAfter(DateTime.now()))
                  scheduleAlarmDateTime = _alarmTime;
                else
                  scheduleAlarmDateTime = _alarmTime.add(Duration(days: 1));

                if (repeat == false) {
                  Aviso avU = Aviso(
                      active: true,
                      alarmDateTime: _alarmTime,
                      description: _name.text.toString(),
                      days: dias);
                  //alarmaList.add(avU);

                  print(avU);
                  //scheduleAlarm(avU.alarmDateTime, avU.description);
                  Navigator.of(contexto).pop(avU);
                } else {
                  // if (pressedl) {
                  //   dias = dias + " L ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(2));
                  // }
                  // if (pressedm) {
                  //   dias = dias + " M ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(3));
                  // }
                  // if (pressedmi) {
                  //   dias = dias + " MI ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(4));
                  // }
                  // if (pressedj) {
                  //   dias = dias + " J ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(5));
                  // }
                  // if (pressedv) {
                  //   dias = dias + " V ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(6));
                  // }
                  // if (presseds) {
                  //   dias = dias + " S ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(7));
                  // }
                  // if (pressedd) {
                  //   dias = dias + " D ";
                  //   scheduleAlarmRepeat(
                  //       _alarmTime, _name.text.toString(), Day(1));
                  // }
                  Aviso av = Aviso(
                      active: true,
                      alarmDateTime: _alarmTime,
                      description: _name.text.toString(),
                      days: dias);
                  //alarmaList.add(av);

                  print(av);
                  Navigator.of(contexto).pop(av);
                }
                //acState.setAvisos(avis);
                //List<Aviso> avis = acState.getAviso;
              },
              child: Text("Guardar",
                  style: TextStyle(color: Colors.black, fontSize: 30))),
        ]),
      ),
    );
  }

  Widget containerText(Widget widg) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      padding: const EdgeInsets.all(1.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: widg,
    );
  }

  // void scheduleAlarm(DateTime schedtime, String message) async {
  //   var scheduledNotificationDateTime = schedtime;

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     'Channel for Alarm notification',
  //     icon: 'relojit',
  //     sound: RawResourceAndroidNotificationSound('lasolisa'),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //       sound: 'a_long_cold_sting.wav',
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true);
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.schedule(0, 'Alarma', message,
  //       scheduledNotificationDateTime, platformChannelSpecifics);
  // }

  // void scheduleAlarmRepeat(DateTime schedtime, String message, Day day) async {
  //   //var scheduledNotificationDateTime = schedtime;
  //   Time tim = Time(schedtime.hour, schedtime.minute);

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'alarm_notif',
  //     'alarm_notif',
  //     'Channel for Alarm notification',
  //     icon: 'relojit',
  //     sound: RawResourceAndroidNotificationSound('lasolisa'),
  //   );

  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //       sound: 'a_long_cold_sting.wav',
  //       presentAlert: true,
  //       presentBadge: true,
  //       presentSound: true);
  //   var platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
  //       0, "Alarma", message, day, tim, platformChannelSpecifics);
  //   //schedule(0,'Alarma',message,scheduledNotificationDateTime,platformChannelSpecifics);
  // }

  DateTime searchNextDay(var day) {
    var dia = day;
    var buscado = new DateTime.now();

    while (buscado.weekday != dia) {
      buscado = buscado.subtract(new Duration(days: 1));
    }

    print('Recent monday $buscado');
    return buscado;
  }
}
