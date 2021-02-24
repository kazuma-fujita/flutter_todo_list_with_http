// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'todo_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) {
  return _TodoEntity.fromJson(json);
}

/// @nodoc
class _$TodoEntityTearOff {
  const _$TodoEntityTearOff();

// ignore: unused_element
  _TodoEntity call({@required int id, @required String title}) {
    return _TodoEntity(
      id: id,
      title: title,
    );
  }

// ignore: unused_element
  TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $TodoEntity = _$TodoEntityTearOff();

/// @nodoc
mixin _$TodoEntity {
  int get id;
  String get title;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $TodoEntityCopyWith<TodoEntity> get copyWith;
}

/// @nodoc
abstract class $TodoEntityCopyWith<$Res> {
  factory $TodoEntityCopyWith(
          TodoEntity value, $Res Function(TodoEntity) then) =
      _$TodoEntityCopyWithImpl<$Res>;
  $Res call({int id, String title});
}

/// @nodoc
class _$TodoEntityCopyWithImpl<$Res> implements $TodoEntityCopyWith<$Res> {
  _$TodoEntityCopyWithImpl(this._value, this._then);

  final TodoEntity _value;
  // ignore: unused_field
  final $Res Function(TodoEntity) _then;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

/// @nodoc
abstract class _$TodoEntityCopyWith<$Res> implements $TodoEntityCopyWith<$Res> {
  factory _$TodoEntityCopyWith(
          _TodoEntity value, $Res Function(_TodoEntity) then) =
      __$TodoEntityCopyWithImpl<$Res>;
  @override
  $Res call({int id, String title});
}

/// @nodoc
class __$TodoEntityCopyWithImpl<$Res> extends _$TodoEntityCopyWithImpl<$Res>
    implements _$TodoEntityCopyWith<$Res> {
  __$TodoEntityCopyWithImpl(
      _TodoEntity _value, $Res Function(_TodoEntity) _then)
      : super(_value, (v) => _then(v as _TodoEntity));

  @override
  _TodoEntity get _value => super._value as _TodoEntity;

  @override
  $Res call({
    Object id = freezed,
    Object title = freezed,
  }) {
    return _then(_TodoEntity(
      id: id == freezed ? _value.id : id as int,
      title: title == freezed ? _value.title : title as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_TodoEntity with DiagnosticableTreeMixin implements _TodoEntity {
  const _$_TodoEntity({@required this.id, @required this.title})
      : assert(id != null),
        assert(title != null);

  factory _$_TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$_$_TodoEntityFromJson(json);

  @override
  final int id;
  @override
  final String title;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TodoEntity(id: $id, title: $title)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TodoEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TodoEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(title);

  @JsonKey(ignore: true)
  @override
  _$TodoEntityCopyWith<_TodoEntity> get copyWith =>
      __$TodoEntityCopyWithImpl<_TodoEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TodoEntityToJson(this);
  }
}

abstract class _TodoEntity implements TodoEntity {
  const factory _TodoEntity({@required int id, @required String title}) =
      _$_TodoEntity;

  factory _TodoEntity.fromJson(Map<String, dynamic> json) =
      _$_TodoEntity.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  @JsonKey(ignore: true)
  _$TodoEntityCopyWith<_TodoEntity> get copyWith;
}
