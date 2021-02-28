import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/todo_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UpsertTodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isNew =
        ModalRoute.of(context).settings.arguments as TodoEntity == null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo${isNew ? '作成' : '更新'}'),
      ),
      body: _UpsertTodoView(),
    );
  }
}

// class TodoForm extends StatefulWidget {
//   @override
//   _TodoFormState createState() => _TodoFormState();
// }

class _UpsertTodoView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isNew =
        ModalRoute.of(context).settings.arguments as TodoEntity == null;
    useProvider(upsertTodoViewModelProvider.state).when(
      data: (todo) async {
        if (todo != null) {
          await EasyLoading.dismiss();
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context, '${todo.title}を${isNew ? '作成' : '更新'}しました');
          //});
        }
      },
      loading: () async {
        await EasyLoading.show();
      },
      error: (error, _) {
        EasyLoading.dismiss();
        _errorView(error.toString());
      },
    );
    return _TodoForm();
  }

  void _errorView(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      backgroundColor: Colors.grey,
    );
  }
}

// ignore: must_be_immutable
class _TodoForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as TodoEntity;
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
              onPressed: () => _submission(context),
              child: Text('Todoを${todo == null ? '作成' : '更新'}する'),
            ),
          ],
        ),
      ),
    );
  }

  void _submission(BuildContext context) {
    final todo = ModalRoute.of(context).settings.arguments as TodoEntity;
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (todo != null) {
        // viewModelのtodoListを更新
        context.read(upsertTodoViewModelProvider).updateTodo(todo.id, _title);
      } else {
        // viewModelのtodoListを作成
        context.read(upsertTodoViewModelProvider).createTodo(_title);
      }
      // 前の画面に戻る
      // Navigator.pop(context, '$_titleを${todo == null ? '作成' : '更新'}しました');
    }
  }
}
