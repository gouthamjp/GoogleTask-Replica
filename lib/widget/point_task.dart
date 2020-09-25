import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/taskList.dart';

class PointTask extends StatefulWidget {
  final String dat;
  PointTask({
    this.dat,
  });
  @override
  _PointTaskState createState() => _PointTaskState();
}

class _PointTaskState extends State<PointTask> {
  @override
  Widget build(BuildContext context) {
    final listData = Provider.of<TaskList>(context);
    void del() {
      listData.check(widget.dat);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(children: <Widget>[
        GestureDetector(
          onTap: del,
          child: Container(
            margin: EdgeInsets.only(right: 10),
            height: 12,
            width: 12,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey)),
          ),
        ),
        Text(
          widget.dat,
          style: TextStyle(fontSize: 18),
        ),
      ]),
    );
  }
}
