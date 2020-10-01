import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../helper/db_helper.dart';

class TaskList with ChangeNotifier {
  List<TaskModel> _items;


  List<TaskModel> get items {
    return [..._items];
  }

  void addTask(String val,String dat) {
    final temp = TaskModel(
    task:  val,
    dateString: dat,
    fin : 0,
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


  void check(String data) {
    _items.forEach((element) {
      if (element.task == data) {
        element.fin = 1;
      }
    });
  }
}
