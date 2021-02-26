import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_todo_list/todo_api_client.dart';
import 'package:flutter_todo_list/todo_list_view.dart';
import 'package:flutter_todo_list/todo_repository.dart';
import 'package:flutter_todo_list/todo_list_view_model.dart';
import 'package:flutter_todo_list/upsert_todo_view_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiClientProvider = Provider.autoDispose(
  (_) => TodoApiClientImpl(),
);

final todoRepositoryProvider = Provider.autoDispose(
  (ref) => TodoRepositoryImpl(apiClient: ref.read(apiClientProvider)),
);

final todoListViewModelProvider = StateNotifierProvider.autoDispose(
  (ref) => TodoListViewModel(todoRepository: ref.read(todoRepositoryProvider)),
);

final upsertTodoViewModelProvider = StateNotifierProvider.autoDispose(
  (ref) => UpsertTodoViewModel(
      todoListViewModel: ref.watch(todoListViewModelProvider),
      todoRepository: ref.read(todoRepositoryProvider)),
);

void main() {
  debugPaintSizeEnabled = false;
  initEasyLoading();
  runApp(
    ProviderScope(
      child: TodoListView(),
    ),
  );
}

void initEasyLoading() {
  EasyLoading.instance
    ..indicatorSize = 64
    ..userInteractions = false
    ..indicatorType = EasyLoadingIndicatorType.wave
    ..loadingStyle = EasyLoadingStyle.custom
    ..maskType = EasyLoadingMaskType.custom
    ..maskColor = Colors.black.withOpacity(0.1)
    ..textColor = Colors.black
    ..indicatorColor = Colors.black
    ..backgroundColor = Colors.white;
}
