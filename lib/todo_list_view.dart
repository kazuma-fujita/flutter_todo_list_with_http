import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/todo.dart';
import 'package:flutter_todo_list/upsert_todo_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/all.dart';

class Const {
  static const routeNameUpsertTodo = 'upsert-todo';
}

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.white),
      routes: <String, WidgetBuilder>{
        Const.routeNameUpsertTodo: (BuildContext context) => UpsertTodoView(),
      },
      home: TodoList(),
    );
  }
}

class TodoList extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _transitionToNextScreen(context),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    final viewModel = useProvider(todoProvider);
    // viewModelからtodoList取得/監視
    final List<Todo> _todoList = viewModel.todoList;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return _dismissible(_todoList[index], context);
      },
    );
  }

  Widget _dismissible(Todo todo, BuildContext context) {
    // ListViewのswipeができるwidget
    return Dismissible(
      // ユニークな値を設定
      key: UniqueKey(),
      confirmDismiss: (direction) async {
        final confirmResult =
            await _showDeleteConfirmDialog(todo.title, context);
        // Future<bool> で確認結果を返す。False の場合削除されない
        return confirmResult;
      },
      onDismissed: (DismissDirection direction) {
        // viewModelのtodoList要素を削除
        context.read(todoProvider).deleteTodo(todo.id);
        // ToastMessageを表示
        Fluttertoast.showToast(
          msg: '${todo.title}を削除しました',
          backgroundColor: Colors.grey,
        );
      },
      // swipe中ListTileのbackground
      background: Container(
        alignment: Alignment.centerLeft,
        // backgroundが赤/ゴミ箱Icon表示
        color: Colors.red,
        child: const Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: _todoItem(todo, context),
    );
  }

  Widget _todoItem(Todo todo, BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: const Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListTile(
        title: Text(
          todo.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        onTap: () {
          _transitionToNextScreen(context, todo: todo);
        },
      ),
    );
  }

  Future<void> _transitionToNextScreen(BuildContext context,
      {Todo todo = null}) async {
    final result = await Navigator.pushNamed(context, Const.routeNameUpsertTodo,
        arguments: todo);

    if (result != null) {
      // ToastMessageを表示
      Fluttertoast.showToast(
        msg: result.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  Future<bool> _showDeleteConfirmDialog(
      String title, BuildContext context) async {
    final result = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('削除'),
            content: Text('$titleを削除しますか？'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('cancel'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('OK'),
              ),
            ],
          );
        });
    return result;
  }
}
