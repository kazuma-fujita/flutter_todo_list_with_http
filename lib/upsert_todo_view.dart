import 'package:flutter/material.dart';

class UpsertTodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upsert todo'),
      ),
      body: TodoForm(),
    );
  }
}

class TodoForm extends StatefulWidget {
  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _formKey = GlobalKey<FormState>();
  String _todo = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new TextFormField(
              maxLength: 20,
              decoration: const InputDecoration(
                hintText: 'Todoを入力してください',
                labelText: 'Todo',
              ),
              validator: (String todo) {
                return todo.isEmpty ? 'Todoを入力してください' : null;
              },
              onSaved: (String todo) {
                _todo = todo;
              },
            ),
            RaisedButton(
              onPressed: _submission,
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('submit: $_todo')));
    }
  }
}
