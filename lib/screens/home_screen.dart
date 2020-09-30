import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/taskList.dart';
import '../widget/tast_bottom.dart';
import '../widget/point_task.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
   
    final listData = Provider.of<TaskList>(context);
    void _addTask() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BottomTask(),
              ),
            );
          });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 70, top: 35),
            child: Text(
              "My Tasks",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                  itemCount: listData.len(),
                  itemBuilder: (BuildContext context, int i) {
                    return PointTask(
                      dat: listData.items[i].task,
                      strike: listData.items[i].fin,
                    );
                  }),
            ),
          ),
          Container(
            child: Row(children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(right: 230, left: 20, bottom: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.dehaze,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.blue,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        elevation: 25,
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
