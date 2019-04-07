import 'package:flutter/material.dart';
import 'model/todo.dart';
class addList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addListState();
  }
}

class addListState extends State<addList> {
  final _formkey = GlobalKey<FormState>();
  TodoProvider myTodo = TodoProvider();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  labelText: "Subject",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please fill subject";
                  }
                },
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    await myTodo.open().then((r) {
                      myTodo.insert(Todo.data(title.text, false));
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}