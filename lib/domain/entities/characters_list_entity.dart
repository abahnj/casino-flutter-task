import 'package:casino_test/domain/entities/character_entity.dart';
import 'package:equatable/equatable.dart';

class CharactersListEntity extends Equatable {
  const CharactersListEntity({required this.info, required this.characters});

  final PageInfoEntity info;
  final List<CharacterEntity> characters;

  bool get isEmpty => characters.isEmpty;

  @override
  List<Object> get props => [info, characters];
}

class PageInfoEntity extends Equatable {
  const PageInfoEntity({
    required this.count,
    required this.pages,
    required this.next,
    required this.previous,
  });

  final int count;
  final int pages;
  final String? next;
  final String? previous;

  int? get nextPage {
    if (next == null) return null;
    final parts = next!.split('=');
    return int.parse(parts[parts.length - 1]);
  }

  @override
  List<Object> get props => [count, pages];
}
