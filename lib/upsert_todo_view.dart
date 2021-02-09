import 'package:flutter/material.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/todo.dart';
import 'package:hooks_riverpod/all.dart';

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
  String _title = '';

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
                hintText: 'Todoタイトルを入力してください',
                labelText: 'Todoタイトル',
              ),
              validator: (String title) {
                return title.isEmpty ? 'Todoタイトルを入力してください' : null;
              },
              onSaved: (String title) {
                _title = title;
              },
            ),
            RaisedButton(
              onPressed: () => _submission(context),
              child: const Text('Todoに追加'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      // viewModelのtodoListを更新
      context.read(todoProvider).createTodo(Todo(1, _title));
      // 前の画面に戻る
      Navigator.pop(context, _title);
    }
  }
}
