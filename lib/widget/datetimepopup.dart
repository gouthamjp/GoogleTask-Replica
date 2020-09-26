import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../provider/taskList.dart';

class PopUp extends StatefulWidget {
  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  DateTime _popTime;
  CalendarController _calendarController;
  TimeOfDay _timenow = TimeOfDay.now();

  //Local Notification Code

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingAndroid;
  var initializationSettingIOS;
  var initializationSetting;
  Future<void> _demoNotification(DateTime timeS) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'Channel_id', 'Channel_name', 'Channel_description',
        importance: Importance.Max,
        ticker: 'Test ticker',
        priority: Priority.High);
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iosChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0, "Flutter App", "Task Reminder", timeS, platformChannelSpecifics,
        payload: 'test payload');
  }

  void _setNotification(DateTime a) async {
    await _demoNotification(a);
  }
  //Local Notification Code

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    initializationSettingAndroid =
        new AndroidInitializationSettings("app_icon");
    initializationSettingIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSetting = new InitializationSettings(
        initializationSettingAndroid, initializationSettingIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != Null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondRoute()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute()));
                  },
                )
              ],
            ));
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var temp = Provider.of<TaskList>(context);

    //Local Notification part 2

    //Local Notification part 2
    Future<Null> selectTime(BuildContext ctx) async {
      _timenow = await showTimePicker(
        context: ctx,
        initialTime: _timenow,
      );
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.68,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TableCalendar(
                calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    selectedColor: Colors.blue,
                    weekendStyle: TextStyle(color: Colors.blue)),
                calendarController: _calendarController,
                rowHeight: 45,
                headerStyle: HeaderStyle(centerHeaderTitle: false),
              ),
              IconButton(
                icon: Icon(
                  Icons.access_time,
                  size: 35,
                ),
                onPressed: () {
                  selectTime(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel")),
                  FlatButton(
                      onPressed: () {
                        temp.addTimeDate(
                            _calendarController.selectedDay, _timenow);
                        _popTime = _calendarController.selectedDay;
                        _popTime = new DateTime(
                            _calendarController.selectedDay.year,
                            _calendarController.selectedDay.month,
                            _calendarController.selectedDay.day,
                            _timenow.hour,
                            _timenow.minute);
                        _setNotification(_popTime);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Set",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Alert Page"),
        ),
        body: Center(
            child: RaisedButton(
          child: Text("Go back"),
          onPressed: () {
            Navigator.of(context);
          },
        )));
  }
}
