import 'dart:async';

import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/data/data_sources/character_remote_datasource.dart';
import 'package:casino_test/data/repository/characters_repository.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  CharactersRepositoryImpl(this.remoteDataSource);

  final CharacterRemoteDataSource remoteDataSource;

  @override
  Future<Result<CharactersListEntity, Error>> getCharacters(int page) async {
    // Fetch characters list from the remote data source
    final charactersList = await remoteDataSource.getCharacters(page);

    // Convert the data model object to a domain entity object
    return charactersList.map((data) => data.toEntity());
  }
}
