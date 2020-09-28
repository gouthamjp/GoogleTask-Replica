import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../models/task_model.dart';

class TaskList with ChangeNotifier {
  List<TaskModel> _items = [];
  DateTime _localD;

  List<TaskModel> get items {
    return [..._items];
  }

  // void addTimeDate(DateTime one, TimeOfDay two) {
  //   _localD = one;
  //   _localD = new DateTime(one.year, one.month, one.day, two.hour, two.minute);
  // }

  void addTask(String val,DateTime one, TimeOfDay two) {
    TaskModel temp = new TaskModel();
    _localD = one;
    _localD = new DateTime(one.year, one.month, one.day, two.hour, two.minute);
    temp.task = val;
    temp.fin = false;
    temp.aTime = _localD;
  
    _items.add(temp);

    notifyListeners();
  }

  int len() {
    return _items.length;
  }

  void check(String data) {
    _items.removeWhere((element) => element.task == data);
    notifyListeners();
  }
}
