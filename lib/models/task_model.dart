import 'package:flutter/cupertino.dart';

class TaskModel {
  DateTime aTime;
  String stringTime;
  String task;
  bool fin;

  TaskModel({
    this.aTime,
    @required this.task,
    this.fin,
    this.stringTime,
  });
}
