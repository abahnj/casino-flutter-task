import 'package:casino_test/src/core/result_monad.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Object>> call(Params params);
}
