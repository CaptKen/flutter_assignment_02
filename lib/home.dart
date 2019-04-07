import 'package:flutter/material.dart';
import 'model/todo.dart';

class List1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return List1State();
  }
}

class List1State extends State<List1> {
  TodoProvider td = TodoProvider();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> appBarActions = [
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/addList");
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            td.deleteDone();
          });
        },
      )
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Todo"),
          actions: <Widget>[appBarActions[_index]],
        ),
        body: TabBarView(
          children: <Widget>[
            FutureBuilder(
              future: td.open().then((r) {
                return td.getNotDone();
              }),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Todo items = snapshot.data[index];
                      return CheckboxListTile(
                        title: Text("${items.title}"),
                        value: items.done,
                        onChanged: (bool value) {
                          setState(() {
                            items.done = true;
                            td.update(items);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data found.."));
                }
              },
            ),
            FutureBuilder(
              future: td.open().then((r) {
                return td.getDone();
              }),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
                if (snapshot.hasData && snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Todo items = snapshot.data[index];
                      return CheckboxListTile(
                        title: Text("${items.title}"),
                        value: items.done,
                        onChanged: (bool value) {
                          setState(() {
                            items.done = false;
                            td.update(items);
                          });
                        },
                      );
                    },
                  );
                } else {
                  return Center(child: Text("No data found.."));
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: TabBar(
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.blue,
          indicatorColor: Colors.blue,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.list),
              text: "Task",
            ),
            Tab(
              icon: Icon(Icons.done_all),
              text: "Completed",
            ),
          ],
          onTap: (index) {
            setState(() {
              _index = index;
            });
          },
        ),
      ),
    );
  }
}
