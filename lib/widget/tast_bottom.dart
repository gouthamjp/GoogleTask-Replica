import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

import '../provider/taskList.dart';

class BottomTask extends StatefulWidget {
  @override
  _BottomTaskState createState() => _BottomTaskState();
}

class _BottomTaskState extends State<BottomTask> {
  TextEditingController _task = TextEditingController();
  var _date;
  var _selectedTime;

  //Local Notification Code part

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingAndroid;
  var initializationSettingIOS;
  var initializationSetting;

  void _setNotification(DateTime a) async {
    await _demoNotification(a);
  }

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

  @override
  void initState() {
    super.initState();
    initializationSettingAndroid =
        new AndroidInitializationSettings("app_icon");
    initializationSettingIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initializationSetting = new InitializationSettings(
        initializationSettingAndroid, initializationSettingIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onSelectNotification: onSelectNotification);
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

  Future onSelectNotification(String payload) async {
    if (payload != Null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => SecondRoute()));
  }

//local notification part

  @override
  Widget build(BuildContext context) {
    final _listData = Provider.of<TaskList>(context);

    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Oops!"),
      content: Text(
        "Please set a time and date for your reminder :)",
      ),
      actions: [
        okButton,
      ],
    );

    AlertDialog alert2 = AlertDialog(
      title: Text("Oops!"),
      content: Text(
        "You havent mentioned the task yet :)",
      ),
      actions: [
        okButton,
      ],
    );

    //All the variable set

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                padding: EdgeInsets.only(bottom: 30),
                child: TextField(
                  controller: _task,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "New Task",
                    border: InputBorder.none,
                  ),
                )),
            Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.alarm,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      _date = await _selectDateTime(context);

                      _selectedTime = await _selectTime(context);
                    }),
                Container(
                    padding: EdgeInsets.only(left: 180),
                    child: FlatButton(
                      onPressed: () {
                        if (_task.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert2;
                            },
                          );
                        } else if (_date == null || _selectedTime == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        } else {
                          final _popTime = new DateTime(
                            _date.year,
                            _date.month,
                            _date.day,
                            _selectedTime.hour,
                            _selectedTime.minute,
                          );
                          _setNotification(_popTime);
                          _listData.addTask(_task.text, _date, _selectedTime);
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

//picking date function
Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

//picking time function

Future<TimeOfDay> _selectTime(BuildContext context) => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );

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
