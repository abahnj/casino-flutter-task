import 'package:equatable/equatable.dart';

typedef OnStateLoading<R> = R Function();
typedef OnStateError<R, E extends Object> = R Function(E error);
typedef OnStateLoaded<R, D> = R Function(D data);

/// Base state for blocs that do async loading.
/// The error type [E] extends [Object] to not allow `void` for errors. More precise
/// error information should be provided here.
abstract class BlocState<D, E extends Object> extends Equatable {
  const BlocState._();

  static BlocState<D, E> loading<D, E extends Object>() =>
      LoadingBlocState<D, E>();

  static BlocState<D, E> error<D, E extends Object>(E error) =>
      ErrorBlocState<D, E>(error);

  static BlocState<D, E> loaded<D, E extends Object>(D data) =>
      LoadedBlocState<D, E>(data);

  BlocState<D, E> toLoading() => LoadingBlocState<D, E>();

  BlocState<D, E> toError(E error) => ErrorBlocState<D, E>(error);

  BlocState<D, E> toLoaded(D data) => LoadedBlocState<D, E>(data);

  /// Provides a null-safe access to the different states and the
  /// associated [data] or [error], for example to build Widgets. Example:
  ///
  /// ```
  /// return state.match(
  ///   onLoading: () => CircularProgressIndicator(),
  ///   onError: (error) => ErrorContent(error),
  ///   onLoaded: (data) => SuccessContent(data),
  /// );
  /// ```
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  });

  /// Return [true] when the state is loaded and [false] otherwise.
  bool get isLoaded;

  /// A shorthand for getting specific value from [data] field or returning the
  /// [defaultValue] otherwise.
  T getValueOrDefault<T>(
    T Function(D) getter, {
    required T defaultValue,
  }) =>
      match(
        onLoading: () => defaultValue,
        onError: (_) => defaultValue,
        onLoaded: (data) => getter(data),
      );
}

class LoadingBlocState<D, E extends Object> extends BlocState<D, E> {
  const LoadingBlocState() : super._();

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onLoading();

  @override
  bool get isLoaded => false;

  @override
  List<Object?> get props => [];
}

class ErrorBlocState<D, E extends Object> extends BlocState<D, E> {
  const ErrorBlocState(this.error) : super._();

  final E error;

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onError(error);

  @override
  bool get isLoaded => false;

  @override
  List<Object?> get props => [error];
}

class LoadedBlocState<D, E extends Object> extends BlocState<D, E> {
  const LoadedBlocState(this.data) : super._();

  final D data;

  @override
  R match<R>({
    required OnStateLoading<R> onLoading,
    required OnStateError<R, E> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onLoaded(data);

  @override
  bool get isLoaded => true;

  @override
  List<Object?> get props => [data];
}
