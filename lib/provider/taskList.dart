import 'package:flutter/cupertino.dart';

import '../models/task_model.dart';

class TaskList with ChangeNotifier {
  List<TaskModel> _items = [];

  List<TaskModel> get items {
    return [..._items];
  }

  void addTask(String val) {
    TaskModel temp = new TaskModel();

    temp.task = val;
    temp.fin = false;
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
