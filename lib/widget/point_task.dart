import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/taskList.dart';

class PointTask extends StatefulWidget {
  final String datnow;
  final String dat;
  final int strike;
  PointTask({
    this.dat,
    this.strike,
    this.datnow,
  });
  @override
  _PointTaskState createState() => _PointTaskState();
}

class _PointTaskState extends State<PointTask> {
  @override
  Widget build(BuildContext context) {
    final listData = Provider.of<TaskList>(context);
    void del() {
      listData.check(widget.dat,widget.datnow,1);
    }

    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            setState(() {
              del();
            });
          },
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
        Expanded(
                  child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
            widget.dat,
            style: TextStyle(fontSize: 18, decoration: widget.strike>0? TextDecoration.lineThrough:TextDecoration.none),
          ),
          Text(widget.datnow,style: TextStyle(fontSize: 8, decoration: widget.strike>0? TextDecoration.lineThrough:TextDecoration.none)),
                    ],
                  ),
        ),
      ]),
    );
  }
}
