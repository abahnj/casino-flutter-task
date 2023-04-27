import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

typedef OnSuccess<T, R> = R Function(T data);
typedef OnError<E, R> = R Function(Object error);

/// Null-safe implementation of Result that is base simplified on Haskel's
/// Either
@sealed
@immutable
abstract class Result<T, E> extends Equatable {
  const Result();

  /// Allows safely matching different states of the result
  ///
  /// If anything throws in [onSuccess] or [onError] then it will NOT be
  /// caught
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  });

  /// Whenever the result is success then the function maps the data with
  /// the mapper.
  /// When the result is error, then no mapping is done and the error
  /// is returned
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Result<R, E> map<R>(R Function(T data) mapper);

  /// Whenever the result is success then the function maps the result into a
  /// new result
  /// When the result is error, then no mapping is done and the error
  /// is returned
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Result<R, E> flatMap<R extends Object>(
    Result<R, E> Function(T data) mapper,
  );

  /// Whenever the result is success then the function maps the result into a
  /// new async result.
  ///
  /// When the result is error, then no mapping is done and the error
  /// is returned
  ///
  /// It enables chaining the async API operations.error
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Future<Result<R, E>> asyncFlatMap<R extends Object?>(
    Future<Result<R, E>> Function(T data) mapper,
  );

  /// Combines successful values of 2 results using [combine].
  ///
  /// If any result is an error then return the first error
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Future<Result<R, E>> asyncLift2<R extends Object, T1>(
    Future<Result<T1, E>> result,
    R Function(T data1, T1 data2) combine,
  );

  /// Combines successful values of 3 results using [combine].
  ///
  /// If any result is an error then return the first error
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Future<Result<R, E>> asyncLift3<R extends Object, T1, T2>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    R Function(T data1, T1 data2, T2 data3) combine,
  );

  /// Combines successful values of 4 results using [combine].
  ///
  /// If any result is an error then return the first error
  /// If mapper throws, then the error will be converted to [ErrorResult]
  Future<Result<R, E>> asyncLift4<R extends Object, T1, T2, T3>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    Future<Result<T3, E>> result3,
    R Function(T data0, T1 data1, T2 data2, T3 data3) combine,
  );

  /// Unwraps the value. This can throw en exception if the result is an error,
  /// therefore it always HAS TO be in try-catch block.
  T getUnsafe();

  /// Creates [Result] from an async function that could throw
  static Future<Result<T, E>> fromAsync<T, E extends Object>(
    Future<T> Function() action,
  ) async {
    try {
      return SuccessResult(data: await action());
    } catch (e) {
      return ErrorResult(error: e);
    }
  }
}

/// [Result] that calls [onSuccess] when matched.
class SuccessResult<T, E> extends Result<T, E> {
  final T data;

  /// For type `void` [data] must be specified as `null`.
  const SuccessResult({required this.data});

  @override
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  }) =>
      onSuccess(data);

  @override
  Result<R, E> map<R>(R Function(T data) mapper) {
    try {
      return SuccessResult(data: mapper(data));
    } catch (e) {
      return ErrorResult(
        error: e,
      );
    }
  }

  @override
  Result<R, E> flatMap<R extends Object>(
    Result<R, E> Function(T data) mapper,
  ) {
    try {
      return mapper(data);
    } catch (e) {
      return ErrorResult(error: e);
    }
  }

  @override
  T getUnsafe() => data;

  @override
  List<Object?> get props => [data];

  @override
  Future<Result<R, E>> asyncFlatMap<R extends Object?>(
    Future<Result<R, E>> Function(T data) mapper,
  ) async {
    try {
      return await mapper(data);
    } catch (e) {
      return ErrorResult(
        error: e,
      );
    }
  }

  @override
  Future<Result<R, E>> asyncLift2<R extends Object, T1>(
    Future<Result<T1, E>> result,
    R Function(T data0, T1 data1) combine,
  ) async =>
      (await result).map((data) => combine(this.data, data));

  @override
  Future<Result<R, E>> asyncLift3<R extends Object, T1, T2>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    R Function(T data0, T1 data1, T2 data2) combine,
  ) async =>
      (await result1)
          .asyncLift2(result2, (data1, data2) => combine(data, data1, data2));

  @override
  Future<Result<R, E>> asyncLift4<R extends Object, T1, T2, T3>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    Future<Result<T3, E>> result3,
    R Function(T data0, T1 data1, T2 data2, T3 data3) combine,
  ) async =>
      (await result1).asyncLift3(
        result2,
        result3,
        (data1, data2, data3) => combine(data, data1, data2, data3),
      );
}

/// [Result] that calls [onError] when matched.
class ErrorResult<T, E> extends Result<T, E> {
  final Object error;

  const ErrorResult({required this.error});

  @override
  R match<R>({
    required OnSuccess<T, R> onSuccess,
    required OnError<E, R> onError,
  }) =>
      onError(error);

  @override
  Result<R, E> map<R>(R Function(T data) mapper) => ErrorResult(
        error: error,
      );

  @override
  Result<R, E> flatMap<R extends Object>(
    Result<R, E> Function(T data) mapper,
  ) =>
      ErrorResult(error: error);

  @override
  T getUnsafe() => throw error;

  @override
  List<Object> get props => [error];

  @override
  Future<Result<R, E>> asyncFlatMap<R extends Object?>(
    Future<Result<R, E>> Function(T data) mapper,
  ) async =>
      ErrorResult(error: error);

  @override
  Future<Result<R, E>> asyncLift2<R extends Object, T1>(
    Future<Result<T1, E>> result,
    R Function(T data1, T1 data2) combine,
  ) async =>
      ErrorResult(error: error);

  @override
  Future<Result<R, E>> asyncLift3<R extends Object, T1, T2>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    R Function(T data1, T1 data2, T2 data3) combine,
  ) async =>
      ErrorResult(error: error);

  @override
  Future<Result<R, E>> asyncLift4<R extends Object, T1, T2, T3>(
    Future<Result<T1, E>> result1,
    Future<Result<T2, E>> result2,
    Future<Result<T3, E>> result3,
    R Function(T data0, T1 data1, T2 data2, T3 data3) combine,
  ) async =>
      ErrorResult(error: error);
}
