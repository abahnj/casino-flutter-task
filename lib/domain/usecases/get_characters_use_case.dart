import 'package:casino_test/core/result_monad.dart';
import 'package:casino_test/core/use_cases/use_case.dart';
import 'package:casino_test/data/repository/characters_repository.dart';
import 'package:casino_test/domain/entities/characters_list_entity.dart';

class GetCharacters implements UseCase<CharactersListEntity, int> {
  final CharactersRepository repository;

  GetCharacters(this.repository);

  @override
  Future<Result<CharactersListEntity, Object>> call(int page) {
    return repository.getCharacters(page);
  }
}
