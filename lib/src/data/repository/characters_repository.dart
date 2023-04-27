import 'package:casino_test/src/core/result_monad.dart';

import '../../domain/entities/characters_list_entity.dart';

abstract class CharactersRepository {
  Future<Result<CharactersListEntity, Error>> getCharacters(int page);
}
