import 'package:flutter/material.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/todo.dart';
import 'package:hooks_riverpod/all.dart';

class UpsertTodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as Todo;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo${todo == null ? '作成' : '更新'}'),
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
    final todo = ModalRoute.of(context).settings.arguments as Todo;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFormField(
              initialValue: todo != null ? todo.title : '',
              maxLength: 20,
              // maxLength以上入力不可
              maxLengthEnforced: true,
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
              onPressed: () => _submission(context, todo),
              child: Text('Todoを${todo == null ? '作成' : '更新'}する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context, Todo todo) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (todo != null) {
        // viewModelのtodoListを更新
        context.read(todoViewModelProvider).updateTodo(todo.id, _title);
      } else {
        // viewModelのtodoListを作成
        context.read(todoViewModelProvider).createTodo(_title);
      }
      // 前の画面に戻る
      Navigator.pop(context, '$_titleを${todo == null ? '作成' : '更新'}しました');
    }
  }
}
