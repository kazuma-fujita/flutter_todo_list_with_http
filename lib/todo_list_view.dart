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
      title: 'Todo List Widget',
      theme: ThemeData(primaryColor: Colors.white),
      routes: <String, WidgetBuilder>{
        Const.routeNameUpsertTodo: (BuildContext context) => UpsertTodoView(),
      },
      home: TodoList(),
    );
  }
}

class TodoList extends HookWidget {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo一覧'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => transitionToNextScreen(context),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    // viewModelからtodoList取得/監視
    final _todoList = useProvider(todoProvider).todoList;
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
        // TODO: AlertDialogで確認を行うこと
        // Future<bool> で確認結果を返す
        // False の場合削除されない
        return true;
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
          print('tapped');
          transitionToNextScreen(context, todo: todo);
        },
      ),
    );
  }

  Future<void> transitionToNextScreen(BuildContext context,
      {Todo todo = null}) async {
    final result = await Navigator.pushNamed(context, Const.routeNameUpsertTodo,
        arguments: todo);

    debugPrint('result: ${result.toString()}');

    if (result != null) {
      // ToastMessageを表示
      Fluttertoast.showToast(
        msg: '${result.toString()}を${todo == null ? '作成' : '更新'}しました',
        backgroundColor: Colors.grey,
      );
    }
  }
}
