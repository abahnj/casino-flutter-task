import 'package:casino_test/src/domain/entities/characters_list_entity.dart';
import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object?> get props => [];
}

class GetTestDataOnMainPageEvent extends MainPageEvent {
  final int page;

  const GetTestDataOnMainPageEvent(this.page);

  @override
  List<Object?> get props => [page];
}

class LoadingDataOnMainPageEvent extends MainPageEvent {
  const LoadingDataOnMainPageEvent();

  @override
  List<Object?> get props => [];
}

class DataLoadedOnMainPageEvent extends MainPageEvent {
  final CharactersListEntity characterList;

  const DataLoadedOnMainPageEvent(this.characterList);

  @override
  List<Object?> get props => [characterList];
}
