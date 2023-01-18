// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'redeem_history_http_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RedeemHistoryHttpRequest {
  int get page => throw _privateConstructorUsedError;
  int get limitPerPage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RedeemHistoryHttpRequestCopyWith<RedeemHistoryHttpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedeemHistoryHttpRequestCopyWith<$Res> {
  factory $RedeemHistoryHttpRequestCopyWith(RedeemHistoryHttpRequest value,
          $Res Function(RedeemHistoryHttpRequest) then) =
      _$RedeemHistoryHttpRequestCopyWithImpl<$Res, RedeemHistoryHttpRequest>;
  @useResult
  $Res call({int page, int limitPerPage});
}

/// @nodoc
class _$RedeemHistoryHttpRequestCopyWithImpl<$Res,
        $Val extends RedeemHistoryHttpRequest>
    implements $RedeemHistoryHttpRequestCopyWith<$Res> {
  _$RedeemHistoryHttpRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limitPerPage = null,
  }) {
    return _then(_value.copyWith(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limitPerPage: null == limitPerPage
          ? _value.limitPerPage
          : limitPerPage // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RedeemHistoryHttpRequestCopyWith<$Res>
    implements $RedeemHistoryHttpRequestCopyWith<$Res> {
  factory _$$_RedeemHistoryHttpRequestCopyWith(
          _$_RedeemHistoryHttpRequest value,
          $Res Function(_$_RedeemHistoryHttpRequest) then) =
      __$$_RedeemHistoryHttpRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int page, int limitPerPage});
}

/// @nodoc
class __$$_RedeemHistoryHttpRequestCopyWithImpl<$Res>
    extends _$RedeemHistoryHttpRequestCopyWithImpl<$Res,
        _$_RedeemHistoryHttpRequest>
    implements _$$_RedeemHistoryHttpRequestCopyWith<$Res> {
  __$$_RedeemHistoryHttpRequestCopyWithImpl(_$_RedeemHistoryHttpRequest _value,
      $Res Function(_$_RedeemHistoryHttpRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? page = null,
    Object? limitPerPage = null,
  }) {
    return _then(_$_RedeemHistoryHttpRequest(
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limitPerPage: null == limitPerPage
          ? _value.limitPerPage
          : limitPerPage // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RedeemHistoryHttpRequest implements _RedeemHistoryHttpRequest {
  const _$_RedeemHistoryHttpRequest(
      {required this.page, this.limitPerPage = 10});

  @override
  final int page;
  @override
  @JsonKey()
  final int limitPerPage;

  @override
  String toString() {
    return 'RedeemHistoryHttpRequest(page: $page, limitPerPage: $limitPerPage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RedeemHistoryHttpRequest &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limitPerPage, limitPerPage) ||
                other.limitPerPage == limitPerPage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, page, limitPerPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RedeemHistoryHttpRequestCopyWith<_$_RedeemHistoryHttpRequest>
      get copyWith => __$$_RedeemHistoryHttpRequestCopyWithImpl<
          _$_RedeemHistoryHttpRequest>(this, _$identity);
}

abstract class _RedeemHistoryHttpRequest implements RedeemHistoryHttpRequest {
  const factory _RedeemHistoryHttpRequest(
      {required final int page,
      final int limitPerPage}) = _$_RedeemHistoryHttpRequest;

  @override
  int get page;
  @override
  int get limitPerPage;
  @override
  @JsonKey(ignore: true)
  _$$_RedeemHistoryHttpRequestCopyWith<_$_RedeemHistoryHttpRequest>
      get copyWith => throw _privateConstructorUsedError;
}
