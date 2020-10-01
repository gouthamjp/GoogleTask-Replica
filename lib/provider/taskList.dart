import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../helper/db_helper.dart';

class TaskList with ChangeNotifier {
  List<TaskModel> _items;

  List<TaskModel> get items {
    return [..._items];
  }

  void addTask(String val, String dat, int st) {
    final temp = TaskModel(
      task: val,
      dateString: dat,
      fin: st,
    );

    _items.add(temp);

    notifyListeners();
    DBHelper.insert('user_places', {
      'task': temp.task,
      'date': temp.dateString,
      'fin': temp.fin,
    });
  }

  Future<void> fetchAndSetTasks() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => TaskModel(
            task: item['task'],
            dateString: item['date'],
            fin: item['fin'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> check(String data, String date, int b) async {
    var up = await DBHelper().update('user_places', data, date, b);

    _items.forEach((element) {
      if (element.task == data) {
        element.fin = 1;
      }
    });
    notifyListeners();
  }
}
