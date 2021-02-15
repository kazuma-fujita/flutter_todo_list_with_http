import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_todo_list/todo_list_view.dart';
import 'package:flutter_todo_list/todo_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModel(),
);

void main() {
  debugPaintSizeEnabled = false;
  runApp(
    ProviderScope(
      child: TodoListView(),
    ),
  );
}
