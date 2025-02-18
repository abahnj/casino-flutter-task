import 'dart:convert';

import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/data/models/characters_list.dart';
import 'package:http/http.dart';

abstract class CharacterRemoteDataSource {
  Future<Result<CharactersList, Error>> getCharacters(int page);
}

class CharacterRemoteDataSourceImpl implements CharacterRemoteDataSource {
  final Client client;

  CharacterRemoteDataSourceImpl({required this.client});

  @override
  Future<Result<CharactersList, Error>> getCharacters(int page) async {
    try {
      // Fetch data from the API and convert it to a list of Character objects
      final charResult = await client
          .get(
            Uri.parse("https://rickandmortyapi.com/api/character/?page=$page"),
          )
          .timeout(const Duration(seconds: 5));
      final jsonMap =
          await json.decode(charResult.body) as Map<String, dynamic>;

      return SuccessResult(data: CharactersList.fromJson(jsonMap));
    } catch (error) {
      return ErrorResult(error: error);
    }
  }
}
