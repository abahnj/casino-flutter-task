import 'package:equatable/equatable.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object?> get props => [];
}

class FetchCharacters extends CharactersEvent {
  const FetchCharacters();
}

class RetryAfterFailure extends CharactersEvent {
  const RetryAfterFailure();
}
