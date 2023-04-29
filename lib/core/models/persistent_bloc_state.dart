import 'package:equatable/equatable.dart';

import 'bloc_state.dart';

typedef OnPersistentStateLoading<R, D extends Object?> = R Function(D? data);
typedef OnPersistentStateError<R, E extends Object, D extends Object?> = R
    Function(E error, D? data);
typedef OnPersistentStateLoaded<R, D> = R Function(D? data);

/// Base state for blocs that do async loading and provide previous data for
/// loading and error state.
///
/// The difference between [BlocState] and [PersistentBlocState] is that
/// you cannot access previous data in [BlocState].
///
/// [PersistentBlocState] should be used when you need to show loading/error
/// state together with previous data.
abstract class PersistentBlocState<D extends Object?, E extends Object>
    extends Equatable {
  const PersistentBlocState._(this.data);

  final D? data;

  static PersistentBlocState<D, E> loading<D, E extends Object>(D? data) =>
      PersistentLoadingBlocState<D, E>(data: data);

  static PersistentBlocState<D, E> error<D, E extends Object>(
    E error,
    D? data,
  ) =>
      PersistentErrorBlocState<D, E>(error, data: data);

  static PersistentBlocState<D, E> loaded<D, E extends Object>(D data) =>
      PersistentLoadedBlocState<D, E>(data);

  PersistentBlocState<D, E> toLoading(D? data) =>
      PersistentLoadingBlocState<D, E>(data: data);

  PersistentBlocState<D, E> toError(E error, {D? data}) =>
      PersistentErrorBlocState<D, E>(error, data: data);

  PersistentBlocState<D, E> toLoaded(D data) =>
      PersistentLoadedBlocState<D, E>(data);

  /// Updates the underlying data without changing the lifecycle of the state.
  PersistentBlocState<D, E> update(D data) => match(
        onError: (E error, D? _) => toError(error, data: data),
        onLoaded: (D _) => toLoaded(data),
        onLoading: (D? _) => toLoading(data),
      );

  /// Provides a null-safe access to the different states and the
  /// associated [data] or [error], for example to build Widgets. Example:
  ///
  /// ```
  /// return state.match(
  ///   onLoading: (data) => CircularProgressIndicator(),
  ///   onError: (error, data) => ErrorContent(error),
  ///   onLoaded: (data) => SuccessContent(data),
  /// );
  /// ```
  R match<R>({
    required OnPersistentStateLoading<R, D> onLoading,
    required OnPersistentStateError<R, E, D> onError,
    required OnStateLoaded<R, D> onLoaded,
  });

  /// A shorthand for getting specific value from [data] field or returning the
  /// [defaultValue] otherwise.
  T getValueOrDefault<T>(
    T Function(D) getter, {
    required T defaultValue,
    bool useGetterForErrorIfPossible = true,
    bool useGetterForLoadingIfPossible = false,
  }) =>
      match(
        onLoading: (data) => (data != null && useGetterForLoadingIfPossible)
            ? getter(data)
            : defaultValue,
        onError: (_, data) => (data != null && useGetterForErrorIfPossible)
            ? getter(data)
            : defaultValue,
        onLoaded: (data) => getter(data),
      );
}

class PersistentLoadingBlocState<D extends Object?, E extends Object>
    extends PersistentBlocState<D, E> {
  const PersistentLoadingBlocState({required D? data}) : super._(data);

  @override
  R match<R>({
    required OnPersistentStateLoading<R, D> onLoading,
    required OnPersistentStateError<R, E, D> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onLoading(data);

  @override
  List<Object?> get props => [data];
}

class PersistentErrorBlocState<D extends Object?, E extends Object>
    extends PersistentBlocState<D, E> {
  const PersistentErrorBlocState(this.error, {required D? data})
      : super._(data);

  final E error;

  @override
  R match<R>({
    required OnPersistentStateLoading<R, D> onLoading,
    required OnPersistentStateError<R, E, D> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onError(error, data);

  @override
  List<Object?> get props => [error, data];
}

class PersistentLoadedBlocState<D, E extends Object>
    extends PersistentBlocState<D, E> {
  const PersistentLoadedBlocState(D super.data)
      : _data = data,
        super._();

  final D _data;

  @override
  R match<R>({
    required OnPersistentStateLoading<R, D> onLoading,
    required OnPersistentStateError<R, E, D> onError,
    required OnStateLoaded<R, D> onLoaded,
  }) =>
      onLoaded(_data);

  @override
  List<Object?> get props => [data];
}
