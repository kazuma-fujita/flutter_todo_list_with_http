import 'package:flutter_todo_list/todo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'todo_state.freezed.dart';

@freezed
abstract class TodoState with _$TodoState {
  const factory TodoState({
    @Default(<Todo>[]) List<Todo> todoList,
  }) = _TodoState;
}
