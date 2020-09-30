import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../helper/db_helper.dart';

class TaskList with ChangeNotifier {
  List<TaskModel> _items;


  List<TaskModel> get items {
    return [..._items];
  }

  void addTask(String val) {
    final temp = TaskModel(
    task:  val,
    fin : false,
    );

    _items.add(temp);

    notifyListeners();
    DBHelper.insert('user_places', {
      'task': temp.task,
    });
  }

  Future<void> fetchAndSetTasks() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => TaskModel(
            task: item['task'],
            fin: false,
          ),
        )
        .toList();
        notifyListeners();
  }


  void check(String data) {
    _items.forEach((element) {
      if (element.task == data) {
        element.fin = true;
      }
    });
  }
}
