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
    final todo = ModalRoute.of(context).settings.arguments as TodoEntity;
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo${todo == null ? '作成' : '更新'}'),
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
    useProvider(upsertTodoViewModelProvider.state).maybeWhen(
      data: (todo) => {
        if (todo != null)
          {
            EasyLoading.dismiss(),
            Navigator.pop(context, '${todo.title}を登録しました'),
          }
      },
      // loading: () => EasyLoading.show,
      error: (error, _) => {
        EasyLoading.dismiss(),
        _errorView(error.toString()),
      },
      orElse: () {},
    );
    return TodoForm();
  }

  void _errorView(String errorMessage) {
    Fluttertoast.showToast(
      msg: errorMessage,
      backgroundColor: Colors.grey,
    );
    // return const Scaffold();
  }
}

// ignore: must_be_immutable
class TodoForm extends StatelessWidget {
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
              // onPressed: EasyLoading.show,
              // onPressed: _submission(context, todo),
              // onPressed: () => _submission(context, todo),
              onPressed: () => _submission(context, todo),
              child: Text('Todoを${todo == null ? '作成' : '更新'}する'),
            ),
          ],
        ),
      ),
    );
  }

  // void _loadingView(BuildContext context) {
  //   final alert = AlertDialog(
  //     content: Row(
  //       children: [
  //         const CircularProgressIndicator(),
  //         Container(
  //             margin: const EdgeInsets.only(left: 7),
  //             child: const Text('Loading...')),
  //       ],
  //     ),
  //   );
  //   showDialog<bool>(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }
  Future<void> _submission(BuildContext context, TodoEntity todo) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      await EasyLoading.show();
      if (todo != null) {
        // viewModelのtodoListを更新
        await context
            .read(upsertTodoViewModelProvider)
            .updateTodo(todo.id, _title);
      } else {
        // viewModelのtodoListを作成
        await context.read(upsertTodoViewModelProvider).createTodo(_title);
      }
      // 前の画面に戻る
      // Navigator.pop(context, '$_titleを${todo == null ? '作成' : '更新'}しました');
    }
  }
}
