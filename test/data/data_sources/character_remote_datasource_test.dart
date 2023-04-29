import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/data/data_sources/character_remote_datasource.dart';
import 'package:casino_test/data/models/characters_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  late CharacterRemoteDataSourceImpl dataSource;
  late _MockClient mockClient;

  setUp(() {
    mockClient = _MockClient();
    dataSource = CharacterRemoteDataSourceImpl(client: mockClient);
  });

  group('getCharacters', () {
    const testPage = 1;
    const testResponseJson = '''
    {
      "info": {
        "count": 1,
        "pages": 1,
        "next": null,
        "prev": null
      },
      "results": [
        {
          "id": 1,
          "name": "Rick Sanchez",
          "status": "Alive",
          "species": "Human",
          "type": "",
          "gender": "Male",
          "origin": {
            "name": "Earth (C-137)",
            "url": "https://rickandmortyapi.com/api/location/1"
          },
          "location": {
            "name": "Earth (Replacement Dimension)",
            "url": "https://rickandmortyapi.com/api/location/20"
          },
          "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
          "episode": [
            "https://rickandmortyapi.com/api/episode/1"
          ]
        }
      ]
    }
    ''';

    test('returns CharactersList on successful API call', () async {
      // Arrange
      when(() => mockClient.get(
            Uri.parse(
                "https://rickandmortyapi.com/api/character/?page=$testPage"),
          )).thenAnswer((_) async => Response(testResponseJson, 200));

      // Act
      final result = await dataSource.getCharacters(testPage);

      // Assert
      expect(result, isA<SuccessResult<CharactersList, Object>>());
      final successResult = result as SuccessResult<CharactersList, Object>;
      expect(successResult.data.characters, isNotEmpty);
    });

    test('returns Error on failed API call', () async {
      // Arrange
      when(() => mockClient.get(
            Uri.parse(
                "https://rickandmortyapi.com/api/character/?page=$testPage"),
          )).thenThrow(Exception('API call failed'));

      // Act
      final result = await dataSource.getCharacters(testPage);

      // Assert
      expect(result, isA<ErrorResult>());
      final errorResult = result as ErrorResult;
      expect(errorResult.error, isA<Exception>());
    });
  });
}

class _MockClient extends Mock implements Client {}
