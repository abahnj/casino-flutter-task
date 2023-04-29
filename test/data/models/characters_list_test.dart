import 'package:casino_test/data/models/character.dart';
import 'package:casino_test/data/models/characters_list.dart';
import 'package:casino_test/data/models/location.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CharactersList', () {
    test('fromJson creates CharactersList from JSON data', () {
      final jsonData = {
        "info": {
          "count": 826,
          "pages": 42,
          "next": null,
          "prev": "https://rickandmortyapi.com/api/character/?page=41"
        },
        "results": [
          {
            "id": 821,
            "name": "Gotron",
            "status": "unknown",
            "species": "Robot",
            "type": "Ferret Robot",
            "gender": "Genderless",
            "origin": {
              "name": "Earth (Replacement Dimension)",
              "url": "https://rickandmortyapi.com/api/location/20"
            },
            "location": {
              "name": "Earth (Replacement Dimension)",
              "url": "https://rickandmortyapi.com/api/location/20"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/821.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/48"],
            "url": "https://rickandmortyapi.com/api/character/821",
            "created": "2021-11-02T17:15:24.788Z"
          },
          {
            "id": 822,
            "name": "Young Jerry",
            "status": "unknown",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "location": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/822.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/51"],
            "url": "https://rickandmortyapi.com/api/character/822",
            "created": "2021-11-02T17:18:31.934Z"
          },
          {
            "id": 823,
            "name": "Young Beth",
            "status": "unknown",
            "species": "Human",
            "type": "",
            "gender": "Female",
            "origin": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "location": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/823.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/51"],
            "url": "https://rickandmortyapi.com/api/character/823",
            "created": "2021-11-02T17:19:00.951Z"
          },
          {
            "id": 824,
            "name": "Young Beth",
            "status": "unknown",
            "species": "Human",
            "type": "",
            "gender": "Female",
            "origin": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "location": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/824.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/51"],
            "url": "https://rickandmortyapi.com/api/character/824",
            "created": "2021-11-02T17:19:47.957Z"
          },
          {
            "id": 825,
            "name": "Young Jerry",
            "status": "unknown",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "location": {
              "name": "Earth (Unknown dimension)",
              "url": "https://rickandmortyapi.com/api/location/30"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/825.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/51"],
            "url": "https://rickandmortyapi.com/api/character/825",
            "created": "2021-11-02T17:20:14.305Z"
          },
          {
            "id": 826,
            "name": "Butter Robot",
            "status": "Alive",
            "species": "Robot",
            "type": "Passing Butter Robot",
            "gender": "Genderless",
            "origin": {
              "name": "Earth (Replacement Dimension)",
              "url": "https://rickandmortyapi.com/api/location/20"
            },
            "location": {
              "name": "Earth (Replacement Dimension)",
              "url": "https://rickandmortyapi.com/api/location/20"
            },
            "image":
                "https://rickandmortyapi.com/api/character/avatar/826.jpeg",
            "episode": ["https://rickandmortyapi.com/api/episode/9"],
            "url": "https://rickandmortyapi.com/api/character/826",
            "created": "2021-11-02T17:24:37.458Z"
          }
        ]
      };

      final charactersList = CharactersList.fromJson(jsonData);

      expect(charactersList, isA<CharactersListEntity>());
      expect(charactersList.info, isA<PageInfoEntity>());
      expect(charactersList.characters.length, 6);
    });

    test('toEntity creates CharactersListEntity from CharactersList', () {
      final charactersList = CharactersList(
        info: const PageInfo(count: 10, pages: 2, next: null, previous: null),
        characters: [
          Character(
            id: 1,
            name: 'Rick',
            status: 'Alive',
            species: 'Human',
            type: '',
            gender: 'Male',
            origin: const Location(
                name: 'Earth',
                url: 'https://rickandmortyapi.com/api/location/1'),
            location: const Location(
                name: 'Earth',
                url: 'https://rickandmortyapi.com/api/location/20'),
            image: 'https://rick.png',
            episode: const ['https://rickandmortyapi.com/api/episode/1'],
          ),
        ],
      );

      final charactersListEntity = charactersList.toEntity();

      expect(charactersListEntity, isA<CharactersListEntity>());
      expect(charactersListEntity.info, isA<PageInfoEntity>());
      expect(charactersListEntity.characters.length, 1);
    });
  });

  group('PageInfo', () {
    test('fromJson creates PageInfo from JSON data', () {
      final jsonData = {
        'count': 10,
        'pages': 2,
        'next': 'https://rickandmortyapi.com/api/character/?page=2',
        'prev': null,
      };

      final pageInfo = PageInfo.fromJson(jsonData);

      expect(pageInfo, isA<PageInfoEntity>());
      expect(pageInfo.count, 10);
      expect(pageInfo.pages, 2);
      expect(pageInfo.next, jsonData['next']);
      expect(pageInfo.previous, jsonData['prev']);
    });

    test('toJson creates JSON data from PageInfo', () {
      const pageInfo =
          PageInfo(count: 10, pages: 2, next: null, previous: null);

      final jsonData = pageInfo.toJson();

      expect(jsonData, isA<Map<String, dynamic>>());
      expect(jsonData['count'], 10);
      expect(jsonData['pages'], 2);
      expect(jsonData['next'], pageInfo.next);
      expect(jsonData['prev'], pageInfo.previous);
    });
  });
}
