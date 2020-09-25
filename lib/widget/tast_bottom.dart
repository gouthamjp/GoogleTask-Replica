import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/taskList.dart';
class BottomTask extends StatefulWidget {
  @override
  _BottomTaskState createState() => _BottomTaskState();
}

class _BottomTaskState extends State<BottomTask> {
  @override
  Widget build(BuildContext context) {
    final listData = Provider.of<TaskList>(context);
    TextEditingController _task = TextEditingController();
    return Container(
      color: Color(0xff757575),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight : Radius.circular(10)
              )
            ),
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
                    IconButton(icon: Icon(Icons.short_text,color: Colors.blue,), onPressed: (){}),
                    IconButton(icon: Icon(Icons.calendar_today,color: Colors.blue,), onPressed: (){}),
                    Container(
                      padding: EdgeInsets.only(left: 135),
                      child:FlatButton(
                        onPressed: (){
                          listData.addTask(_task.text);
                          Navigator.pop(context);
                        },
                        child: Text("Save"),
                        
                      )
                    )
                  ],
                )
              ],
            ),
      ),
    );
  }
} 