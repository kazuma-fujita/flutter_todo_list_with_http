import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:flutter_todo_list/todo_list_view.dart';
import 'package:flutter_todo_list/todo_view_model.dart';

final todoProvider = ChangeNotifierProvider(
  (ref) => TodoViewModel(),
);

void main() {
  debugPaintSizeEnabled = true;
  // runApp(TodoListView());
  runApp(
    ProviderScope(
      child: TodoListView(),
    ),
  );
}
