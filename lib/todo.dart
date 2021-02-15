import 'package:flutter/material.dart';

@immutable
class Todo {
  const Todo(this.id, this.title);
  final int id;
  final String title;
}
