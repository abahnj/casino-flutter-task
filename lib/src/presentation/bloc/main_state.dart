import 'package:casino_test/src/domain/entities/characters_list_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {}

class InitialMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class LoadingMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class UnSuccessfulMainPageState extends MainPageState {
  @override
  List<Object> get props => [];
}

class SuccessfulMainPageState extends MainPageState {
  final CharactersListEntity characterList;

  SuccessfulMainPageState(this.characterList);

  @override
  List<Object> get props => [characterList];
}
