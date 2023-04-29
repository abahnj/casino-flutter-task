import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';

abstract class CharactersRepository {
  Future<Result<CharactersListEntity, Error>> getCharacters(int page);
}
