import 'package:casino_test/core/result_monad.dart';

abstract class UseCase<Type, Params> {
  Future<Result<Type, Object>> call(Params params);
}
