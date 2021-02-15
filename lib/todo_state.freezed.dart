// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'todo_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$TodoStateTearOff {
  const _$TodoStateTearOff();

// ignore: unused_element
  _TodoState call({List<Todo> todoList = const <Todo>[]}) {
    return _TodoState(
      todoList: todoList,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $TodoState = _$TodoStateTearOff();

/// @nodoc
mixin _$TodoState {
  List<Todo> get todoList;

  @JsonKey(ignore: true)
  $TodoStateCopyWith<TodoState> get copyWith;
}

/// @nodoc
abstract class $TodoStateCopyWith<$Res> {
  factory $TodoStateCopyWith(TodoState value, $Res Function(TodoState) then) =
      _$TodoStateCopyWithImpl<$Res>;
  $Res call({List<Todo> todoList});
}

/// @nodoc
class _$TodoStateCopyWithImpl<$Res> implements $TodoStateCopyWith<$Res> {
  _$TodoStateCopyWithImpl(this._value, this._then);

  final TodoState _value;
  // ignore: unused_field
  final $Res Function(TodoState) _then;

  @override
  $Res call({
    Object todoList = freezed,
  }) {
    return _then(_value.copyWith(
      todoList: todoList == freezed ? _value.todoList : todoList as List<Todo>,
    ));
  }
}

/// @nodoc
abstract class _$TodoStateCopyWith<$Res> implements $TodoStateCopyWith<$Res> {
  factory _$TodoStateCopyWith(
          _TodoState value, $Res Function(_TodoState) then) =
      __$TodoStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Todo> todoList});
}

/// @nodoc
class __$TodoStateCopyWithImpl<$Res> extends _$TodoStateCopyWithImpl<$Res>
    implements _$TodoStateCopyWith<$Res> {
  __$TodoStateCopyWithImpl(_TodoState _value, $Res Function(_TodoState) _then)
      : super(_value, (v) => _then(v as _TodoState));

  @override
  _TodoState get _value => super._value as _TodoState;

  @override
  $Res call({
    Object todoList = freezed,
  }) {
    return _then(_TodoState(
      todoList: todoList == freezed ? _value.todoList : todoList as List<Todo>,
    ));
  }
}

/// @nodoc
class _$_TodoState with DiagnosticableTreeMixin implements _TodoState {
  const _$_TodoState({this.todoList = const <Todo>[]})
      : assert(todoList != null);

  @JsonKey(defaultValue: const <Todo>[])
  @override
  final List<Todo> todoList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoState(todoList: $todoList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoState'))
      ..add(DiagnosticsProperty('todoList', todoList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoState &&
            (identical(other.todoList, todoList) ||
                const DeepCollectionEquality()
                    .equals(other.todoList, todoList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(todoList);

  @JsonKey(ignore: true)
  @override
  _$TodoStateCopyWith<_TodoState> get copyWith =>
      __$TodoStateCopyWithImpl<_TodoState>(this, _$identity);
}

abstract class _TodoState implements TodoState {
  const factory _TodoState({List<Todo> todoList}) = _$_TodoState;

  @override
  List<Todo> get todoList;
  @override
  @JsonKey(ignore: true)
  _$TodoStateCopyWith<_TodoState> get copyWith;
}
