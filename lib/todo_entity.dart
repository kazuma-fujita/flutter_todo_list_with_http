import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_entity.freezed.dart';
part 'todo_entity.g.dart';

@freezed
abstract class TodoEntity with _$TodoEntity {
  const factory TodoEntity({
    @required final int id,
    @required final String title,
  }) = _TodoEntity;

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);
}
