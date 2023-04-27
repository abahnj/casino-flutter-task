import 'package:casino_test/src/core/result_monad.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/domain/entities/characters_list_entity.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Object>> call(Params params);
}

class GetCharacters implements UseCase<CharactersListEntity, int> {
  final CharactersRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Result<CharactersListEntity, Object>> call(int page) {
    return repository.getCharacters(page);
  }
}
