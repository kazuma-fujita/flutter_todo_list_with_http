import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/todo.dart';
import 'package:flutter_todo_list/upsert_todo_view.dart';
import 'package:hooks_riverpod/all.dart';

class TodoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List Widget',
      theme: ThemeData(primaryColor: Colors.white),
      routes: <String, WidgetBuilder>{
        'upsert-todo': (BuildContext context) => UpsertTodoView(),
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
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, 'upsert-todo'),
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    // viewModelからtodoList取得/監視
    final _todos = useProvider(todoProvider).todos;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext context, int index) {
        return _todoItem(_todos[index]);
      },
      itemCount: _todos.length,
    );
  }

  Widget _todoItem(Todo todo) {
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
        },
      ),
    );
  }
}
