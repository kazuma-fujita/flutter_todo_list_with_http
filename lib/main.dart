import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_todo_list/todo_api_client.dart';
import 'package:flutter_todo_list/todo_list_view.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:flutter_todo_list/todo_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiClientProvider = Provider(
  (_) => TodoApiClientImpl(),
);

final todoRepositoryProvider = Provider(
  (ref) => TodoRepositoryImpl(apiClient: ref.read(apiClientProvider)),
);

final todoViewModelProvider = StateNotifierProvider(
  (ref) => TodoViewModel(todoRepository: ref.read(todoRepositoryProvider)),
);

void main() {
  debugPaintSizeEnabled = false;
  runApp(
    ProviderScope(
      child: TodoListView(),
    ),
  );
}
